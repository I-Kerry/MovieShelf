//
//  MovieDetailMovie.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 07.10.2026.
//

import Foundation

struct MovieDetailModel: Hashable {
    let title: String
    let rating: Double
    let releaseDate: Int?
    let overview: String
    let posterURL: URL?
    let backdropURL: URL?
}
