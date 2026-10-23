//
//  DetailViewModelTests.swift
//  MovieShelfTests
//
//  Created by Kirill Maidanovich on 22.10.2026.
//

import Foundation
@testable import MovieShelf
import Testing
import SwiftData

@MainActor
struct DetailViewModelTests {
    private func makeDetailsDTO(id: Int) -> MovieDetailsDTO {
        MovieDetailsDTO(
            backdropPath: nil,
            belongsToCollection: nil,
            genres: [],
            id: id,
            overview: "",
            posterPath: nil,
            releaseDate: "",
            runtime: nil,
            title: "lox",
            voteAverage: 0,
            voteCount: 0)
    }
    
    let container: ModelContainer
    let repository: WatchlistRepository

    init() throws {
        container = try ModelContainer(
            for: SDWatchListItem.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        repository = WatchlistRepository(context: container.mainContext)
    }
    
    @Test func durationFormatter() {
        let vm = MovieDetailViewModel(service: FakeApi(), movieId: 1)
        #expect(vm.durationFormatter(45) == "45m")
        #expect(vm.durationFormatter(100) == "1h 40m")
        #expect(vm.durationFormatter(0) == nil)
        #expect(vm.durationFormatter(nil) == nil)
        #expect(vm.durationFormatter(60) == "1h")
    }
    
    @Test func toggleWatchlist_addsThenRemoves() async {
        let api = FakeApi()
        let vm = MovieDetailViewModel(service: api, movieId: 10)
        api.response = [
            .success(makeDetailsDTO(id: 10))
        ]
        vm.repository = repository
        
        await vm.loadDetails()
        vm.loadSavedState()
        #expect(vm.isSaved == false)
        
        vm.toggleWatchlist()
        #expect(vm.isSaved == true)
        #expect(repository.contains(10))
        
        vm.toggleWatchlist()
        #expect(vm.isSaved == false)
        #expect(!repository.contains(10))
    }
    
    @Test func loadedSuccessfully() async {
        let api = FakeApi()
        let vm = MovieDetailViewModel(service: api, movieId: 1)
        
        api.response = [
            .success(makeDetailsDTO(id: 1))
        ]
        
        await vm.loadDetails()
        
        #expect(api.requestedEndpoints == [.movie(id: 1)])
        guard case .loaded(let model) = vm.state else {
            Issue.record("expected .loaded but \(vm.state) appeared")
            return
        }
        #expect(model.title == "lox")
    }
    
    @Test func loadingFailed() async {
        let api = FakeApi()
        let vm = MovieDetailViewModel(service: api, movieId: 1)
        
        api.response = [
            .failure(URLError(.timedOut))
        ]
        
        await vm.loadDetails()
        
        if case .error = vm.state { } else { Issue.record("expected .error but \(vm.state) appeared") }
        
        #expect(api.requestedEndpoints == [.movie(id: 1)])
    }
}
