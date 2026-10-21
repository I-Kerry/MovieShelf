//
//  MovieShelfTests.swift
//  MovieShelfTests
//
//  Created by Kirill Maidanovich on 20.10.2026.
//

import Testing
@testable import MovieShelf

@MainActor
struct SeeAllViewModelTests {
    
    private func makeDTO(id: Int) -> MovieDTO {
        MovieDTO(
            backdropPath: nil,
            genreIds: [1,2,3],
            id: 1,
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
        api.response = [
            .success(MoviesResponse(page: 1, results: [makeDTO(id: 1), makeDTO(id: 2)], totalPages: 2, totalResults: 4))
        ]
        let vm = SeeAllViewModel(service: api, category: .popular)
        

        // Act
        await vm.loadFirstPage()
        print("Запросы к API: \(api.requestedEndpoints)") // Сходил ли ViewModel в API?
            print("Количество фильмов: \(vm.movies.count)") // Сколько фильмов пришло?
        // Assert
        let ids = vm.movies.map(\.id)
        let expectedIds: [Int] = [1, 2]
        
        #expect(api.requestedEndpoints == [.popular(page: 1)])
        #expect(ids == expectedIds)
    }
}
