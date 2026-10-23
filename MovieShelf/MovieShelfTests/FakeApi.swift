//
//  FakeApi.swift
//  MovieShelfTests
//
//  Created by Kirill Maidanovich on 20.10.2026.
//

import Foundation
@testable import MovieShelf

final class FakeApi: APIClientProtocol {
    
    var response: [Result<Any, Error>] = []
    private(set) var requestedEndpoints: [TMDBEndpoints] = []
    
    func fetch<T: Decodable>(_ endpoint: TMDBEndpoints) async throws -> T {
        requestedEndpoints.append(endpoint)
        guard !response.isEmpty else { throw URLError(.badServerResponse) }
        switch response.removeFirst() {
        case .success(let response):
            guard let typed = response as? T else { fatalError("Fake: unexpected type \(T.self)")}
            return typed
        case .failure(let error):
            throw error
        }
    }
}
