//
//  SeeAllViewModel.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 19.10.2026.
//

import Foundation

enum MovieCategory: Hashable {
    case popular, nowPlaying, upcoming, topRated
    
    var title: String {
        switch self {
        case .popular:
            "Popular Films"
        case .nowPlaying:
            "Now Playing"
        case .upcoming:
            "Coming Soon"
        case .topRated:
            "Top Rated"
        }
    }
    
    func endpoint(page: Int) -> TMDBEndpoints {
        switch self {
        case .popular:
                .popular(page: page)
        case .nowPlaying:
                .nowPlaying(page: page)
        case .upcoming:
                .upcoming(page: page)
        case .topRated:
                .topRated(page: page)
        }
    }
}

@MainActor
@Observable
final class SeeAllViewModel {
    let service: APIClientProtocol
    let category: MovieCategory
    private(set) var movies: [MoviePreviewModel] = []
    private(set) var state: LoadingState<Void> = .idle
    private var page: Int = 1
    private var canLoadMore = false
    private(set) var isLoadingMore = false
    var sorting: SortOption = .serverOrder
    var sortedMovies: [MoviePreviewModel] {
        sorting.apply(to: movies)
    }
    
    init(service: APIClientProtocol, category: MovieCategory) {
        self.service = service
        self.category = category
    }
    
    func loadFirstPage() async {
        guard case .idle = state else { return }
        state = .loading

        do {
            let response: MoviesResponse = try await service.fetch(category.endpoint(page: page))
            movies = response.results.map { $0.toPreviewModel() }
            canLoadMore = response.page < response.totalPages
            state = .loaded(())
        } catch {
            state = .error("Can't be uploaded")
        }
    }
    
    func loadNextPage() async {
        guard canLoadMore && !isLoadingMore else { return }
        isLoadingMore = true
        defer { isLoadingMore = false }
        do {
            let response: MoviesResponse = try await service.fetch(category.endpoint(page: page + 1))
            movies.append(contentsOf: response.results.map { $0.toPreviewModel() })
            page += 1
            canLoadMore = response.page < response.totalPages
        } catch {
            //: MARK: = it's reasonable not to handle this error
        }
    }
    
    func retry() async {
        state = .idle
        await loadFirstPage()
    }
}
