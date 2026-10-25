//
//  WatchListView.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 16.10.2026.
//

import SwiftUI
import SwiftData

struct WatchListView: View {
    @Environment(\.watchlistRepository) private var repository
    @Query(sort: \SDWatchListItem.addedAt, order: .reverse) private var likedFilms: [SDWatchListItem]
    @State private var isSelecting = false
    @State private var selectedIds: Set<Int> = []
    @State private var showDeleteConfirmation = false
    @State private var sorting: WatchlistSort = .recentlyAdded
    private let service: APIClientProtocol
    private var sortedMovies: [SDWatchListItem] {
        sorting.apply(to: likedFilms)
    }
    
    init(service: APIClientProtocol) {
        self.service = service
    }
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, spacing: Constraints.spacing) {
                    ForEach(sortedMovies, id: \.id) { film in
                        Group {
                            if isSelecting {
                                Button {
                                    toggleSelection(film.id)
                                } label: {
                                    WatchListCell(item: film)
                                }
                            } else {
                                NavigationLink(value: film.id) { WatchListCell(item: film) }
                            }
                        }
                        .buttonStyle(.plain)
                        .overlay(alignment: .topTrailing) {
                            if isSelecting {
                                Image(systemName: selectedIds.contains(film.id) ? Icons.checkmarkFill : Icons.circle)
                                    .padding(Constraints.smallerSpacing)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Int.self) { movieId in
                MovieDetailView(service: service, movieId: movieId)
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if !isSelecting {
                        Menu {
                            Picker(Titles.sortingTitle, selection: $sorting) {
                                ForEach(WatchlistSort.allCases, id: \.self) { option in
                                    Text(option.title).tag(option)
                                }
                            }
                        } label: {
                            Image(systemName: Icons.horizontalLines)
                        }
                    }
                    
                    Button {
                        isSelecting.toggle()
                        selectedIds.removeAll()
                    } label: {
                        Image(systemName: isSelecting ?  Icons.xMarkCircle : Icons.arrowTrash)
                    }
                }
                if isSelecting {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("\(Titles.delete) (\(selectedIds.count))", role: .destructive) {
                            showDeleteConfirmation = true
                        }
                        .disabled(selectedIds.isEmpty)
                    }
                }
            }
            
        }
        
        .confirmationDialog("\(Titles.delete) \(selectedIds.count) movie(s)?", isPresented: $showDeleteConfirmation, titleVisibility: .visible) {
            Button(Titles.delete, role: .destructive) {
                try? repository?.remove(Array(selectedIds))
                selectedIds.removeAll()
                isSelecting = false
            }
            Button(Titles.cancel) {
                showDeleteConfirmation = false
            }
        }
    }
    
    private func toggleSelection(_ id: Int) {
        if selectedIds.contains(id) { selectedIds.remove(id) } else { selectedIds.insert(id) }
    }
}
