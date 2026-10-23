//
//  SeeAllView.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 19.10.2026.
//

import SwiftUI

struct SeeAllView: View {
    @State private var viewModel: SeeAllViewModel
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(service: APIClientProtocol, category: MovieCategory) {
        _viewModel = State(initialValue: SeeAllViewModel(service: service, category: category))
    }
    
    var body: some View {
        
        mainContent
        
            .task {
                await viewModel.loadFirstPage()
            }
            .navigationTitle(viewModel.category.title)
            .navigationDestination(for: Int.self) { movieId in
                MovieDetailView(service: viewModel.service, movieId: movieId)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Sorting", selection: $viewModel.sorting) {
                            ForEach(SortOption.allCases, id: \.self) { option in
                                Text(option.title).tag(option)
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.circle")
                    }
                }
            }
    }
    
    @ViewBuilder
    private var mainContent: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
        case .loaded:
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, spacing: Constraints.smallerSpacing) {
                    ForEach(viewModel.sortedMovies, id: \.id) { movie in
                        NavigationLink(value: movie.id) {
                            MoviePreviewCell(model: movie)
                        }
                        .buttonStyle(.plain)
                        .onAppear {
                            if movie.id == viewModel.sortedMovies.last?.id {
                                Task { await viewModel.loadNextPage() }
                            }
                        }
                    }
                }
                if viewModel.isLoadingMore == true {
                    ProgressView()
                }
            }
            
        case .error:
            VStack(alignment: .center) {
                Text("Can't be uploaded")
                Button("Try again") {
                    Task { await viewModel.retry() }
                }
            }
            
        }
    }
}

