//
//  MovieShelfApp.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 24.08.2026.
//

import SwiftUI
import SwiftData

@main
struct MovieShelfApp: App {
    private let container: ModelContainer
    private let repository: WatchlistRepository
    init() {
        let container = try! ModelContainer(for: SDWatchListItem.self)
        self.container = container
        self.repository = WatchlistRepository(context: container.mainContext)
    }
    var body: some Scene {
        WindowGroup {
            ContentView(service: TMDBService())
        }
        .modelContainer(container)
//        .modelContainer(for: SDWatchListItem.self)
        .environment(\.watchlistRepository, repository)
    }
}
