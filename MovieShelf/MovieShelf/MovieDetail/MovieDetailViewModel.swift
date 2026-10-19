//
//  MovieDetailViewModel.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 07.10.2026.
//

import Foundation

@Observable
@MainActor
final class MovieDetailViewModel {
    private(set) var state: LoadingState<MovieDetailModel> = .idle
    private let service: APIClientProtocol
    var repository: WatchlistRepository?
    private(set) var isSaved: Bool = false
    private let movieId: Int
    
    init(service: APIClientProtocol, movieId: Int) {
        self.service = service
        self.movieId = movieId
    }
    
    func loadDetails(movieID: Int) async {
        state = .loading
        
        do {
            let dto: MovieDetailsDTO = try await service.fetch(.movie(id: movieID))
            state = .loaded(dto.toDetailModel())
        } catch {
            state = .error("Can't be uploaded")
        }
    }
    
    func durationFormatter(_ mins: Int?) -> String? {
        guard let mins, mins > 0 else { return nil }
        return "\(mins / 60)h \(mins % 60)m"
    }
    
    func loadSavedState() {
        isSaved = repository?.contains(movieId) ?? false
    }
    
    func toggleWatchlist(movieId: Int) {
        if isSaved {
            repository?.remove([movieId])
        } else {
            guard case .loaded(let details) = state else { return }
            repository?.add(id: movieId, title: details.title, posterURL: details.posterURL?.absoluteString, voteAverage: details.rating, releaseDate: details.releaseDate)
        }
        isSaved = repository?.contains(movieId) ?? false
    }
}
