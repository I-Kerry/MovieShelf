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
    
    init(service: APIClientProtocol, movieId: Int) {
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
                    Button(Titles.tryAgain) { Task { await viewModel.loadDetails()} }
                }
            }
        }
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    try? viewModel.toggleWatchlist()
                } label: {
                    viewModel.isSaved ? Image(systemName: Icons.rectangleFill) : Image(systemName: Icons.rectangle)
                }
            }
        }
        
        .task {
            await viewModel.loadDetails()
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
            } placeholder: { Color.gray.opacity(Opacity.lowOpacity)}
                .frame(height: DetailViewSizes.height).clipped()
                .overlay(alignment: .bottomLeading) {
                    AsyncImage(url: movie.posterURL) {
                        $0.resizable().scaledToFill()
                    } placeholder: { Color.gray.opacity(Opacity.lowOpacity) }
                        .frame(width: DetailViewSizes.placeholderWidth ,height: DetailViewSizes.placeholderHeight).clipped()
                        .overlay {
                            RoundedRectangle(cornerRadius: Constraints.cornerRadius)
                                .stroke(Color.white, lineWidth: DetailViewSizes.contentLineBorderSize)
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
                                .padding(.horizontal, Constraints.usualSpacing)
                                .padding(.vertical, Constraints.smallerSpacing)
                                .background(Capsule().fill(Color.blue.opacity(Opacity.lowOpacity)))
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
