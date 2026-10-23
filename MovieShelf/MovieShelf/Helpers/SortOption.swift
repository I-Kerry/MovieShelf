//
//  SortOption.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 23.10.2026.
//

import Foundation

enum SortOption: CaseIterable {
    case serverOrder
    case rating
    case releaseDate
    case title
    
    var title: String {
        switch self {
        case .serverOrder:
            "Default"
        case .rating:
            "Rating"
        case .releaseDate:
            "Date"
        case .title:
            "Name"
        }
    }
    func apply(to movies: [MoviePreviewModel]) -> [MoviePreviewModel] {
        switch self {
        case .serverOrder: movies
        case .rating: movies.sorted(using: [
            KeyPathComparator(\.rating, order: .reverse),
            KeyPathComparator(\.name),
            KeyPathComparator(\.id)
        ])
        case .releaseDate: movies.sorted(using: [
            KeyPathComparator(\.year, order: .reverse),
            KeyPathComparator(\.name),
            KeyPathComparator(\.id)
        ])
        case .title: movies.sorted(using: [
            KeyPathComparator(\.name, comparator: .localizedStandard),
            KeyPathComparator(\.id)
        ])
        }
    }
}
