//
//  Repository.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 17.10.2026.
//

import SwiftUI
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
    }
    
    func contains(_ movieId: Int) -> Bool {
        let descriptor = FetchDescriptor<SDWatchListItem>(predicate: #Predicate {$0.id == movieId })
        return (( try? context.fetchCount(descriptor)) ?? 0) > 0
    }
    
    func remove(_ movieIds: [Int]) throws -> Void {
        do {
            let descriptor = FetchDescriptor<SDWatchListItem>(predicate: #Predicate { movieIds.contains($0.id)})
            let items = try context.fetch(descriptor)
            items.forEach {
                context.delete($0)
            }
            try save()
        } catch {
            throw SDError.removalError(error)
        }
    }
    
    private func save() throws {
        do {
            try context.save()
        } catch {
            throw SDError.savingError(error)
        }
    }
}
