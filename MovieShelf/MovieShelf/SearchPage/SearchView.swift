//
//  SearchView.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 09.10.2026.
//

import SwiftUI

struct SearchView: View {
    @State var viewModel: SearchViewModel
    @State var selectedGenre: Genre?
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField(Titles.fieldPlaceholder, text: $viewModel.text)
                    .task(id: viewModel.text) {
                        await viewModel.search()
                    }
                    .foregroundStyle(Color.gray)
                    .padding()
                GenreView(selectedGenre: $selectedGenre, genres: GenreMock.allGenres)
                    .onChange(of: selectedGenre) {
                        viewModel.text = ""
                    }
                mainContent
            }
            .navigationDestination(for: Int.self) { movieID in
                MovieDetailView(service: viewModel.service, movieId: movieID)
            }
            .onChange(of: viewModel.text) {
                if !viewModel.text.isEmpty { selectedGenre = nil }
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
    
    @ViewBuilder
    private var mainContent: some View {
        if let genre = selectedGenre {
            SeeAllView(service: viewModel.service, category: .genre(id: genre.id, name: genre.name))
                .id(genre.id)
        } else {
            content
        }
    }
}
