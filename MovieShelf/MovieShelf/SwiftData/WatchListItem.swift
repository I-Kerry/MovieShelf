//
//  WatchListItem.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 16.10.2026.
//

import Foundation
import SwiftData

@Model
final class SDWatchListItem {
    @Attribute(.unique) var id: Int
    var title: String
    var posterURL: String?
    var voteAverage: Double?
    var releaseDate: Int?
    var addedAt: Date = Date.now
    
    init(id: Int, title: String, posterURL: String? = nil, voteAverage: Double? = nil, releaseDate: Int? = nil, addedAt: Date) {
        self.id = id
        self.title = title
        self.posterURL = posterURL
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
        self.addedAt = addedAt
    }
}
