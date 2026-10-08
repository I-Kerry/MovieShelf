//
//  SearchModel.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 08.10.2026.
//

import Foundation

struct SearchModel: Identifiable, Hashable {
    let id: Int
    let posterURL: URL?
    let title: String
    let releaseYear: Int?
    let genre: String?
    let rating: Double
}
