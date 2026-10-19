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
        Group {
            mainContent
        }
        .task {
            await viewModel.loadFirstPage()
        }
        .navigationTitle(viewModel.category.title)
    }
    
    @ViewBuilder
    private var mainContent: some View {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView()
            case .loaded:
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .center, spacing: Constraints.smallerSpacing) {
                        ForEach(viewModel.movies, id: \.id) { movie in
                            NavigationLink(value: movie.id) {
                                MoviePreviewCell(model: movie)
                            }
                            .onAppear {
                                if movie.id == viewModel.movies.last?.id {
                                    Task { await viewModel.loadNextPage() }
                                }
                            }
                        }
                    }
                }
            case .error:
                Text("Can't be uploaded")
                Button("Try again") {
                    Task { await viewModel.retry() }
                }
                
        }
    }
}

