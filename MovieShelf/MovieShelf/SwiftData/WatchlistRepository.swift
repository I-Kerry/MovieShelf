//
//  Reposiroty.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 17.10.2026.
//

import Foundation
import SwiftData

@MainActor
final class WatchlistRepository {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func add(
        id: Int,
        title: String,
        posterURL: String?,
        voteAverage: Double?,
        releaseDate: Int?,
        addedAt: Date = .now
    ) {
        let likedFilm = SDWatchListItem(
            id: id,
            title: title,
            posterURL: posterURL,
            voteAverage: voteAverage,
            releaseDate: releaseDate,
            addedAt: addedAt
        )
        context.insert(likedFilm)
//        save()
    }
    
    func contains(_ movieId: Int) -> Bool {
        let descriptor = FetchDescriptor<SDWatchListItem>(predicate: #Predicate {$0.id == movieId })
        return (( try? context.fetchCount(descriptor)) ?? 0) > 0
    }
    
    func remove(_ movieIds: [Int]) -> Void {
        try? context.delete(model: SDWatchListItem.self,
                            where: #Predicate { movieIds.contains($0.id) })
        save()
    }
    
    private func save() {
        do {
            try context.save()
        } catch {
            print("Can't be saved")
        }
    }
}
