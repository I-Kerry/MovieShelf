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
    
    func durationFormatter(_ mins: Int?) -> String? {
        guard let mins, mins > 0 else { return nil }
        return "\(mins / 60)h \(mins % 60)m"
    }
}
