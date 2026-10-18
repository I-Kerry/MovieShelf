//
//  MovieDetailView.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 17.09.2026.
//

import SwiftUI

struct MovieDetailView: View {
    @Environment(\.watchlistRepository) private var repository
    @State private var viewModel: MovieDetailViewModel
    let movieId: Int
    
    init(service: TMDBService, movieId: Int) {
        _viewModel = State(initialValue: MovieDetailViewModel(service: service, movieId: movieId))
        self.movieId = movieId
    }
        
    var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView()
            case .loaded(let movie):
                content(movie)
            case .error(let message):
                VStack {
                    Text(message)
                    Button("Retry") { Task { await viewModel.loadDetails(movieID: movieId)} }
                }
            }
        }
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.toggleWatchlist(movieId: movieId)
                } label: {
                    viewModel.isSaved ? Image(systemName: "plus.rectangle.fill.on.rectangle.fill") : Image(systemName: "plus.rectangle.on.rectangle")
                }
            }
        }
        
        .task {
            await viewModel.loadDetails(movieID: movieId)
        }
        
        .task {
            viewModel.repository = repository
            viewModel.loadSavedState()
        }
    }
    
    @ViewBuilder
    private func content(_ movie: MovieDetailModel) -> some View {
        ScrollView {
            AsyncImage(url: movie.backdropURL) {
                $0.resizable().scaledToFill()
            } placeholder: { Color.gray.opacity(0.2)}
                .frame(height: 200).clipped()
                .overlay(alignment: .bottomLeading) {
                    AsyncImage(url: movie.posterURL) {
                        $0.resizable().scaledToFill()
                    } placeholder: { Color.gray.opacity(0.2) }
                        .frame(width: 80 ,height: 120).clipped()
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white, lineWidth: 3)
                        }
                        .padding()
                }
                
            VStack(alignment: .leading, spacing: Constraints.spacing) {
                
                Text(movie.title)
                    .font(.title.bold())
                Text("★ \(String(format: "%.1f", movie.rating))")
                
                if let year = movie.releaseDate {
                    Text(String(year))
                }
                
                ScrollView(.horizontal ,showsIndicators: false) {
                    HStack(spacing: Constraints.smallerSpacing) {
                        ForEach(movie.genres, id: \.self) { genre in
                            Text(genre)
                                .font(.subheadline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Capsule().fill(Color.blue.opacity(0.2)))
                                .foregroundStyle(.blue)
                        }
                    }
                }
                
                if let formatterDuration = viewModel.durationFormatter(movie.duration) {
                    Text(formatterDuration)
                        .font(.subheadline)
                        .foregroundStyle(Color.black)
                }
                
                Text(movie.overview)
            }
            .padding()
            .ignoresSafeArea(edges: .top)
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
}
