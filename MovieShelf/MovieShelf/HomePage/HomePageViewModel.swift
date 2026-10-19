//
//  HomePageViewModel.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 30.08.2026.
//

import SwiftUI

enum TrendingTimeWindow: String {
    case day
    case week
}

@MainActor
@Observable
final class HomePageViewModel {
    
    let service: APIClientProtocol
    var popular: LoadingState<[MoviePreviewModel]> = .idle
    var nowPlaying: LoadingState<[MoviePreviewModel]> = .idle
    var upcoming: LoadingState<[MoviePreviewModel]> = .idle
    var topRated: LoadingState<[MoviePreviewModel]> = .idle
    var trending: LoadingState<[MoviePreviewModel]> = .idle
    var trendingMovie: MoviePreviewModel?
    
    init(service: APIClientProtocol) {
        self.service = service
    }
    
    private func loadCategories(endpoint: TMDBEndpoints) async -> LoadingState<[MoviePreviewModel]> {
        do {
            let response: MoviesResponse = try await service.fetch(endpoint)
            return .loaded(response.results.map { $0.toPreviewModel() })
        } catch {
            return .error("Can't be uploaded")
        }
    }
    
    func loadAll() async {
        popular = .loading
        popular = await loadCategories(endpoint: .popular(page: 1))
        
        nowPlaying = .loading
        nowPlaying = await loadCategories(endpoint: .nowPlaying(page: 1))
        
        upcoming = .loading
        upcoming = await loadCategories(endpoint: .upcoming(page: 1))
        
        topRated = .loading
        topRated = await loadCategories(endpoint: .topRated(page: 1))
        
        trending = .loading
        trending = await loadCategories(endpoint: .trending(timeWindow: .day))
        if case .loaded(let movie) = trending {
            trendingMovie = movie.randomElement()
        }
    }
}
