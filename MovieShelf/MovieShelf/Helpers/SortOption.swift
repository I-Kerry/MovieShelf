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
            SortOptionTitles.defaultTitle
        case .rating:
            SortOptionTitles.rating
        case .releaseDate:
            SortOptionTitles.date
        case .title:
            SortOptionTitles.name
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

enum WatchlistSort: CaseIterable {
    case recentlyAdded, oldestAdded, rating, releaseDate, title
    
    var title: String {
        switch self {
        case .recentlyAdded:
            SortOptionTitles.newest
        case .oldestAdded:
            SortOptionTitles.oldest
        case .rating:
            SortOptionTitles.rating
        case .releaseDate:
            SortOptionTitles.date
        case .title:
            SortOptionTitles.name
        }
    }
    
    func apply(to movies: [SDWatchListItem]) -> [SDWatchListItem] {
        switch self {
        case .recentlyAdded:
            movies.sorted { $0.addedAt > $1.addedAt }
        case .oldestAdded:
            movies.sorted { $0.addedAt < $1.addedAt }
        case .rating:
            movies.sorted { $0.voteAverage ?? 0 > $1.voteAverage ?? 0 }
        case .releaseDate:
            movies.sorted { $0.releaseDate ?? 0 > $1.releaseDate ?? 0 }
        case .title:
            movies.sorted { $0.title.localizedStandardCompare($1.title) == .orderedAscending }
        }
    }
}
