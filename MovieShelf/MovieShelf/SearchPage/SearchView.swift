//
//  SearchView.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 09.10.2026.
//

import SwiftUI

struct SearchView: View {
    @State var viewModel: SearchViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search movies...", text: $viewModel.text)
                    .task(id: viewModel.text) {
                        await viewModel.search()
                    }
                    .foregroundStyle(Color.gray)
                    .padding()
                
                content
            }
            .navigationDestination(for: Int.self) { movieID in
                MovieDetailView(service: viewModel.service, movieId: movieID)
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            SearchPlaceholder()
        case .loading:
            Spacer()
            ProgressView()
            Spacer()
        case .loaded(let movies):
            ScrollView {
                LazyVStack(alignment: .center) {
                    ForEach(movies) { movie in
                        NavigationLink(value: movie.id) {
                            SearchViewCell(searchModel: movie)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        case .error(let message):
            Spacer()
            Text(message)
            Spacer()
        }
    }
}
