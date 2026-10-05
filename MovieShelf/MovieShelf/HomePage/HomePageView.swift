//
//  HomePageView.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 25.08.2026.
//

import SwiftUI

struct HomePageView: View {
    @State var viewModel: HomePageViewModel
    var body: some View {
                
        title
        mainPageView
            .padding()
        
        mainContent
        
        .task {
            await viewModel.loadAll()
        }
    }
    
    @ViewBuilder
    private var title: some View {
        HStack {
            Text(Titles.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(Constraints.spacing)
                .foregroundStyle(.textMade)
            Spacer()
        }
    }
    
    @ViewBuilder
    private var mainContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constraints.spacing) {
                switch viewModel.popular {
                case .idle, .loading:
                    ProgressView()
                case .loaded(let movies):
                    HStackMoviesView(title: Titles.popularMovies, movies: movies)
                case .error(let message):
                    Text(message)
                }
                
                switch viewModel.nowPlaying {
                case .idle, .loading:
                    ProgressView()
                case .loaded(let movies):
                    HStackMoviesView(title: Titles.nowPlaying, movies: movies)
                case .error(let message):
                    Text(message)
                }
                
                switch viewModel.upcoming {
                case .idle, .loading:
                    ProgressView()
                case .loaded(let movies):
                    HStackMoviesView(title: Titles.upcoming, movies: movies)
                case .error(let message):
                    Text(message)
                }
                
                switch viewModel.topRated {
                case .idle, .loading:
                    ProgressView()
                case .loaded(let movies):
                    HStackMoviesView(title: Titles.top, movies: movies)
                case .error(let message):
                    Text(message)
                }
            }
        }
        .navigationDestination(for: Int.self) { movieId in
            MovieDetailView(id: movieId)
        }
    }
    
    @ViewBuilder
    private var mainPageView: some View {
        if let trendingMovie = viewModel.trendingMovie {
            MainPageImageView(
                imageURL: trendingMovie.posterURL,
                title: trendingMovie.name,
                year: trendingMovie.year,
                genre: trendingMovie.genre, rating: Float(trendingMovie.rating)
            )
        }
    }
}

#Preview {
    HomePageView(viewModel: HomePageViewModel(service: TMDBService()))
}
