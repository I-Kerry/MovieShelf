//
//  Constants.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 24.08.2026.
//

import Foundation

enum ApiKey {
    static let apiKey = "997df483cb6e1eed16321dd7916f5476"
    static let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5OTdkZjQ4M2NiNmUxZWVkMTYzMjFkZDc5MTZmNTQ3NiIsIm5iZiI6MTc4NzU4Mzg1NC40MjksInN1YiI6IjZhOGM1ZDZlZjA0YjJhMWQwOWIzZjBkOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pNzBxD2E_S6J8uzbrV2CmRw-nmgqdXVXMror5CrOvE8"
}

enum Titles {
    static let title = "Movie Shelf"
    static let seeAllButton = "See All"
    static let popularMovies = "Popular Movies"
    static let nowPlaying = "Now Playing"
    static let upcoming = "Upcoming"
    static let top = "Top Rated"
}

enum Icons {
    static let home = "house"
    static let magnifyingGlass = "magnifyingglass"
    static let wishlist = "bookmark"
}

enum Constraints {
    static let spacing: CGFloat = 16
    static let smallerSpacing: CGFloat = 8
    static let smallestSpacing: CGFloat = 4
    static let cornerRadius: CGFloat = 16
}

enum BaseURL {
    static let baseURL = "https://api.themoviedb.org/3"
}

enum TMDBImage {
    static let baseURL = "https://image.tmdb.org/t/p/w500"
}
