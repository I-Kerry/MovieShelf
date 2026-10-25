//
//  Errors.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 27.08.2026.
//

import Foundation

enum ApiErrors: Error {
    case invalidURL
    case noData
    case decodingFailed
    case serverError(statusCode: Int)
    case unauthorized
    case networkUnavailable
    case invalidData
    case unknownError(String)
}

enum SearchError: Error {
    case emptyQuery
}

enum ErrorString {
    static let noRating = "Not rated yet"
    static let cantUpload = "Can't be uploaded"
    static let tokenError = "TMDB_TOKEN is missing. Copy Secrets.example.xcconfig to Secrets.xcconfig and add your token."
}

enum SDError: Error {
    case removalError(Error)
    case savingError(Error)
}
