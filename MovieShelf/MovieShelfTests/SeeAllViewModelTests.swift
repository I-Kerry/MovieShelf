//
//  MovieShelfTests.swift
//  MovieShelfTests
//
//  Created by Kirill Maidanovich on 20.10.2026.
//

import Testing
@testable import MovieShelf
import Foundation

@MainActor
struct SeeAllViewModelTests {
    
    private func makeDTO(id: Int) -> MovieDTO {
        MovieDTO(
            backdropPath: nil,
            genreIds: [1,2,3],
            id: id,
            overview: "fdxfsdthdxbsntlsbldhlsbs",
            posterPath: nil,
            releaseDate: "2096",
            title: "Test",
            voteAverage: 2.9,
            voteCount: 5)
    }
    
    @Test func loadFirstPage_fillsMovies() async {
        // Arrange
        let api = FakeApi()
        let dtos = [makeDTO(id: 1), makeDTO(id: 2)]
        api.response = [
            .success(MoviesResponse(page: 1, results: dtos, totalPages: 2, totalResults: 4))
        ]
        let vm = SeeAllViewModel(service: api, category: .popular)
        // Act
        await vm.loadFirstPage()
        // Assert
        let ids = vm.movies.map(\.id)
        let expectedIds: [Int] = [1, 2]
        
        #expect(api.requestedEndpoints == [.popular(page: 1)])
        #expect(ids == expectedIds)
    }
    
    private func makePage(ids: [Int], page: Int, totalPages: Int) -> MoviesResponse {
        MoviesResponse(page: page, results: ids.map { makeDTO(id: $0) }, totalPages: totalPages, totalResults: ids.count + totalPages )
    }
    
    @Test func loadNextPage_appendsMovies() async {
        // Arrange
        let api = FakeApi()
        api.response = [
            .success(makePage(ids: [1, 2], page: 1, totalPages: 2)),
            .success(makePage(ids: [3, 4], page: 1, totalPages: 2))
        ]
        let vm = SeeAllViewModel(service: api, category: .popular)
        // Act
        await vm.loadFirstPage()
        await vm.loadNextPage()
        // Assert
        #expect(vm.movies.map(\.id) == [1, 2, 3, 4])
        #expect(api.requestedEndpoints == [.popular(page: 1), .popular(page: 2)])
    }
    
    @Test func loadNextPage_doesNothing_whenNoMorePages() async {
        // Arrange
        let api = FakeApi()
        api.response = [
            .success(makePage(ids: [1, 2], page: 1, totalPages: 1))
        ]
        let vm = SeeAllViewModel(service: api, category: .popular)
        //Act
        await vm.loadFirstPage()
        await vm.loadNextPage()
        //Assert
        #expect(api.requestedEndpoints.count == 1)
    }
    
    @Test func loadFirstPage_setsErrorState_onFailure() async {
        // Arrange
        let api = FakeApi()
        api.response = [
            .failure(URLError(.notConnectedToInternet))
        ]
        let vm = SeeAllViewModel(service: api, category: .popular)
        // Act
        await vm.loadFirstPage()
        // Assert
        if case .error = vm.state { } else { Issue.record("Expected .error, but \(vm.state) appeared")}
        #expect(vm.movies.isEmpty)
    }
    
    @Test func loadNextPage_afterFailure_retriesSamePage() async {
        //Arrange
        let api = FakeApi()
        
        api.response = [
            .success(makePage(ids: [1, 2], page: 1, totalPages: 4)),
            .failure(URLError(.timedOut)),
            .success(makePage(ids: [3, 4], page: 2, totalPages: 4))
        ]
        let vm = SeeAllViewModel(service: api, category: .popular)
        // Act
        
        await vm.loadFirstPage()
        await vm.loadNextPage()
        // Assert
        #expect(vm.movies.map(\.id) == [1, 2])
        
        await vm.loadNextPage()
        #expect(vm.movies.map(\.id) == [1, 2, 3, 4])
        #expect(api.requestedEndpoints.suffix(2) == [.popular(page: 2), .popular(page: 2)])
    }
    
    @Test func loadFirstPage_doesntWorkAgain() async {
        // Arrange
        let api = FakeApi()
        
        api.response = [
            .success(makePage(ids: [1, 2], page: 1, totalPages: 2))
        ]
        let vm = SeeAllViewModel(service: api, category: .popular)
        // Act
        await vm.loadFirstPage()
        await vm.loadFirstPage()
        // Assert
        #expect(api.requestedEndpoints.count == 1)
        #expect(vm.movies.map(\.id) == [1, 2])
    }
}
