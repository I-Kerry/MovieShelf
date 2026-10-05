//
//  DecodingModels.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 27.08.2026.
//

import Foundation

struct MovieDetailsDTO: Decodable {
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let genres: [Genre]
    let id: Int
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let runtime: Int?
    let title: String
    let voteAverage: Double
    let voteCount: Int
}

struct BelongsToCollection: Codable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct MoviesResponse: Decodable {
    let page: Int
    let results: [MovieDTO]
    let totalPages: Int
    let totalResults: Int
}

struct MovieDTO: Codable {
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let title: String
    let voteAverage: Double
    let voteCount: Int
}
