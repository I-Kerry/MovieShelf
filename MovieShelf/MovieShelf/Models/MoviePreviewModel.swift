//
//  MovieModel.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 25.08.2026.
//

import SwiftUI

struct MoviePreviewModel: Identifiable {
    let id = UUID()
    let posterURL: URL?
    let name: String
    let year: Int
    let rating: Double
    let genre: String?
}
