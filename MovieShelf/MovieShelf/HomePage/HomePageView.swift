//
//  HomePageView.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 25.08.2026.
//

import SwiftUI

struct HomePageView: View {
    @State var viewModel: HomePageViewModel
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            title
            mainPageView
                .padding()
            
            mainContent
                .task {
                    await viewModel.loadAll()
                }
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
                    HStackMoviesView(title: Titles.popularMovies, movies: movies, action: { path.append(MovieCategory.popular) })
                case .error(let message):
                    Text(message)
                }
                
                switch viewModel.nowPlaying {
                case .idle, .loading:
                    ProgressView()
                case .loaded(let movies):
                    HStackMoviesView(title: Titles.nowPlaying, movies: movies, action: { path.append(MovieCategory.nowPlaying) })
                case .error(let message):
                    Text(message)
                }
                
                switch viewModel.upcoming {
                case .idle, .loading:
                    ProgressView()
                case .loaded(let movies):
                    HStackMoviesView(title: Titles.upcoming, movies: movies, action: { path.append(MovieCategory.upcoming) })
                case .error(let message):
                    Text(message)
                }
                
                switch viewModel.topRated {
                case .idle, .loading:
                    ProgressView()
                case .loaded(let movies):
                    HStackMoviesView(title: Titles.top, movies: movies, action: { path.append(MovieCategory.topRated) })
                case .error(let message):
                    Text(message)
                }
            }
        }
        .navigationDestination(for: Int.self) { movieId in
            MovieDetailView(service: viewModel.service, movieId: movieId)
        }
        .navigationDestination(for: MovieCategory.self) { category in
            SeeAllView(service: viewModel.service, category: category)
        }
    }
    
    @ViewBuilder
    private var mainPageView: some View {
        VStack {
            if let trendingMovie = viewModel.trendingMovie {
                NavigationLink(value: trendingMovie.id) {
                    MainPageImageView(
                        imageURL: trendingMovie.backDrop,
                        title: trendingMovie.name,
                        year: trendingMovie.year,
                        genre: trendingMovie.genre, rating: Float(trendingMovie.rating)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    HomePageView(viewModel: HomePageViewModel(service: TMDBService()))
}
