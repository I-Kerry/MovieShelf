//
//  TMDBEndpoints.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 26.08.2026.
//

import SwiftUI

enum TMDBEndpoints {
    case popular
    case nowPlaying
    case upcoming
    case trending(timeWindow: TrendingTimeWindow)
    case searchMovie(query: String)
    case movie(id: Int)
    case movieCredits(movieId: Int)
    case movieVideos(movieId: Int)
    case movieSimilar(movieId: Int)
    case discover
    case topRated
    
    var path: String {
        switch self {
        case .popular: "/movie/popular"
        case .nowPlaying: "/movie/now_playing"
        case .upcoming: "/movie/upcoming"
        case .trending(let timeWindow): "/trending/movie/\(timeWindow)"
        case .searchMovie: "/search/movie"
        case .movie(let id): "/movie/\(id)"
        case .movieCredits(let movieId): "/movie/\(movieId)/credits"
        case .movieVideos(let movieId): "/movie/\(movieId)/videos"
        case .movieSimilar(let movieId): "/movie/\(movieId)/similar"
        case .discover: "/discover/movie"
        case .topRated: "/movie/top_rated"
        }
    }
}

extension TMDBEndpoints {
    var queryItems: [URLQueryItem] {
        switch self {
        case .popular: []
        case .nowPlaying: []
        case .upcoming: []
        case .trending: []
        case .searchMovie(let query): [URLQueryItem(name: "query", value: query)]
        case .movie: []
        case .movieCredits: []
        case .movieVideos: []
        case .movieSimilar: []
        case .discover: []
        case .topRated: []
        }
    }
    
    func makeURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3\(path)"
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        return components.url
    }
}

#Preview {
    Color.clear
        .task {
            let endpoints: [TMDBEndpoints] = [
                .movie(id: 5),
                .movieVideos(movieId: 12),
                .movieCredits(movieId: 13),
                .movieSimilar(movieId: 14),
                .trending(timeWindow: .day),
                .searchMovie(query: "Alahamoha"),
                .nowPlaying
            ]
            for endpoint in endpoints {
                print(endpoint.makeURL()?.absoluteString ?? "nil")
            }
        }
}
