//
//  HomePageViewModelTests.swift
//  MovieShelfTests
//
//  Created by Kirill Maidanovich on 22.10.2026.
//

import Testing
@testable import MovieShelf
import Foundation

@MainActor

struct HomePageViewModelTests {
    
    private func makeDTO(id: Int) -> MovieDTO {
        return MovieDTO(
            backdropPath: nil,
            genreIds: [],
            id: id,
            overview: "",
            posterPath: "",
            releaseDate: "",
            title: "",
            voteAverage: 0,
            voteCount: 0)
    }
    
    @Test func loadAll() async {
        // Arrange
        let api = FakeApi()
        let vm = HomePageViewModel(service: api)
        api.response = (1...5).map { .success(MoviesResponse(page: 1, results: [makeDTO(id: $0)], totalPages: 1, totalResults: 1))}
        // Act
        await vm.loadAll()
        // Assert
        #expect(api.requestedEndpoints == [.popular(page: 1), .nowPlaying(page: 1), .upcoming(page: 1), .topRated(page: 1), .trending(timeWindow: .day)])
        
        #expect(ids(of: vm.popular) == [1])
        #expect(ids(of: vm.nowPlaying) == [2])
        #expect(ids(of: vm.upcoming) == [3])
        #expect(ids(of: vm.topRated) == [4])
        #expect(ids(of: vm.trending) == [5])
    }
    
    private func ids(of state: LoadingState<[MoviePreviewModel]>) -> [Int]? {
        if case .loaded(let movies) = state { return movies.map(\.id) }
        return nil
    }
    
    @Test func failureFirst_othersSuccess() async {
        // Arrange
        let api = FakeApi()
        let vm = HomePageViewModel(service: api)
        api.response = [
            .failure(URLError(.timedOut)),
            .success(MoviesResponse(page: 1, results: [makeDTO(id: 2)], totalPages: 1, totalResults: 1)),
            .success(MoviesResponse(page: 1, results: [makeDTO(id: 3)], totalPages: 1, totalResults: 1)),
            .success(MoviesResponse(page: 1, results: [makeDTO(id: 4)], totalPages: 1, totalResults: 1)),
            .success(MoviesResponse(page: 1, results: [makeDTO(id: 5)], totalPages: 1, totalResults: 1))
        ]
        
        //Act
        await vm.loadAll()
        
        // Assert
        
        #expect(api.requestedEndpoints == [.popular(page: 1), .nowPlaying(page: 1), .upcoming(page: 1), .topRated(page: 1), .trending(timeWindow: .day)])
        if case .error = vm.popular { } else { Issue.record("Popular must be .error")}
        #expect(ids(of: vm.nowPlaying) == [2])
        #expect(ids(of: vm.upcoming) == [3])
        #expect(ids(of: vm.topRated) == [4])
        #expect(ids(of: vm.trending) == [5])
        #expect(vm.trendingMovie?.id == 5)
    }
    
    @Test func trendingFailure_othersLoadWell() async {
        // Arrange
        let api = FakeApi()
        let vm = HomePageViewModel(service: api)
        
        api.response = (1...5).map { i -> Result<Any, Error> in
            i == 5 ? .failure(URLError(.timedOut)) : .success(MoviesResponse(page: 1, results: [makeDTO(id: i)], totalPages: 1, totalResults: 1))
        }
        // Act
        await vm.loadAll()
        
        // Assert
        if case .error = vm.trending { } else { Issue.record("Trending must be .error")}
        #expect(ids(of: vm.popular) == [1])
        #expect(ids(of: vm.nowPlaying) == [2])
        #expect(ids(of: vm.upcoming) == [3])
        #expect(ids(of: vm.topRated) == [4])
        #expect(vm.trendingMovie == nil)
    }
}
