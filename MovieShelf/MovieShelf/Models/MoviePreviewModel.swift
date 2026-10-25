//
//  MovieModel.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 25.08.2026.
//

import SwiftUI

struct MoviePreviewModel: Identifiable, Hashable {
    let id: Int
    let posterURL: URL?
    let name: String
    let year: Int
    let rating: Double
    let genre: String?
    let backDrop: URL?
}
