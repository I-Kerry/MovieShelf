//
//  MovieDetailViewModel.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 07.10.2026.
//

import Foundation

enum DetailLoadingState<T> {
    case idle
    case loading
    case loaded(T)
    case error(String)
}

@Observable
@MainActor
final class MovieDetailViewModel {
    private(set) var state: DetailLoadingState<MovieDetailModel> = .idle
    private let service: TMDBService
    
    init(service: TMDBService) {
        self.service = service
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
}
