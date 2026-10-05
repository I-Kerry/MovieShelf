//
//  RequestService.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 26.08.2026.
//

import SwiftUI

protocol APIClientProtocol {
    func fetch<T: Decodable>(_ endpoint: TMDBEndpoints) async throws -> T
}

final class TMDBService {
    
    func makeRequest(for endpoint: TMDBEndpoints) -> URLRequest? {
        guard let url = endpoint.makeURL() else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer \(ApiKey.accessToken)"
        ]
        
        return request
    }
    
    func fetch<T: Decodable>(_ endpoint: TMDBEndpoints) async throws -> T {
        guard let request = makeRequest(for: endpoint) else { throw ApiErrors.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw ApiErrors.serverError(statusCode: -1)
        }
        
        switch response.statusCode {
        case 200...299:
            break
        case 401:
            throw ApiErrors.unauthorized
        default:
            throw ApiErrors.serverError(statusCode: response.statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw ApiErrors.decodingFailed
        }
    }
}

#Preview {
    Color.white
        .task {
            let request = TMDBService().makeRequest(for: .popular)
            print(request?.allHTTPHeaderFields ?? [:])
            print(request?.url?.absoluteString ?? "nil")
        }
}
