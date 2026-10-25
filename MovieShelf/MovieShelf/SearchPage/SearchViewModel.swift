//
//  SearchViewModel.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 08.10.2026.
//

import Foundation

@Observable
@MainActor
final class SearchViewModel {
    private(set) var state: LoadingState<[SearchModel]> = .idle
    let service: APIClientProtocol
    private var genres: [Int: String] = [:]
    var text = ""
    
    init(service: APIClientProtocol) {
        self.service = service
    }
    
    func search() async {
        let query = text.trimmingCharacters(in: .whitespaces)
        guard !query.isEmpty else { state = .idle; return }
        
        state = .loading
        
        do {
            let response: MoviesResponse = try await service.fetch(.searchMovie(query: query))
            
            state = .loaded(response.results.map { $0.toSearchModel(genres: genres) })
        } catch {
            state = .error(ErrorString.cantUpload)
        }
    }
}
