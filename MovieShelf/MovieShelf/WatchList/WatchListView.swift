//
//  WatchListView.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 16.10.2026.
//

import SwiftUI
import SwiftData

struct WatchListView: View {
    @Query(sort: \SDWatchListItem.addedAt, order: .reverse) private var likedFilms: [SDWatchListItem]
    private let service: TMDBService
    
    init(service: TMDBService) {
        self.service = service
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, spacing: Constraints.spacing) {
                    ForEach(likedFilms) { film in
                        NavigationLink(value: film.id) {
                            WatchListCell(item: film)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .navigationDestination(for: Int.self) { movieId in
                MovieDetailView(service: service, movieId: movieId)
            }
        }
    }
}
