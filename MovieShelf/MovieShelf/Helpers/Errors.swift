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
