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
    static let sortingTitle = "Sorting"
    static let delete = "Delete"
    static let cancel = "Cancel"
    static let tryAgain = "Try again"
    static let fieldPlaceholder = "Search movies..."
    static let searchPlaceholder = "Search for the film you'd like to know about"
}

enum Icons {
    static let home = "house"
    static let magnifyingGlass = "magnifyingglass"
    static let wishlist = "bookmark"
    static let checkmarkFill = "checkmark.circle.fill"
    static let circle = "circle"
    static let horizontalLines = "line.3.horizontal.circle"
    static let xMarkCircle = "xmark.circle"
    static let arrowTrash = "arrow.up.trash"
    static let photo = "photo"
    static let star = "star.fill"
    static let rectangleFill = "plus.rectangle.fill.on.rectangle.fill"
    static let rectangle = "plus.rectangle.on.rectangle"
}

enum Constraints {
    static let spacing: CGFloat = 16
    static let usualSpacing: CGFloat = 12
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

enum Opacity {
    static let highOpacity = 0.5
    static let lowOpacity = 0.2
}

enum WatchListImageFrame {
    static let height: CGFloat = 250
    static let width: CGFloat = 170
}

enum SearchViewCellSize {
    static let height: CGFloat = 105
    static let width: CGFloat = 70
}
enum MainPageImageViewSize {
    static let height: CGFloat = 210
}
enum HStackMoviesSizes {
    static let cellHeight: CGFloat = 140
    static let cellWidth: CGFloat = 92
    static let textHeight: CGFloat = 50
    static let stackFrame: CGFloat = 250
}

enum DetailViewSizes {
    static let height: CGFloat = 200
    static let placeholderWidth: CGFloat = 80
    static let placeholderHeight: CGFloat = 120
    static let contentLineBorderSize: CGFloat = 3
}

enum Limits {
    static let lineLimit = 2
    static let datePrefix = 4
}

enum DividerItemsFrame {
    static let frameSize: CGFloat = 5
    static let ratingSize: CGFloat = 10
    static let dot = "·"
    static let mainPageDividerHeight: CGFloat = 16
    static let mainPageDividerWidth: CGFloat = 8
}

enum SortOptionTitles {
    static let defaultTitle = "Default"
    static let rating = "Rating"
    static let date = "Date"
    static let name = "Name"
    static let newest = "Fresh"
    static let oldest = "Old but Gold"
}
