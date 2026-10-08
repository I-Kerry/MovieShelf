//
//  MovieDTOExtenstion.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 11.09.2026.
//

import Foundation

extension MovieDTO {
    func toPreviewModel() -> MoviePreviewModel {
        let posterURL: URL? = posterPath.flatMap {
            URL(string: "\(TMDBImage.baseURL)\($0)")
        }
        let year: Int = Int(String(releaseDate.prefix(4))) ?? 0
        let formattedRating = ((voteAverage) * 100).rounded() / 100
        
        return MoviePreviewModel(
            movieId: id,
            posterURL: posterURL,
            name: title,
            year: year,
            rating: formattedRating,
            genre: nil
        )
    }
}
 
extension MovieDetailsDTO {
    
    func toDetailModel() -> MovieDetailModel {
        let posterURL: URL? = posterPath.flatMap {
            URL(string: "\(TMDBImage.baseURL)\($0)")
        }
        let backdropURL: URL? = backdropPath.flatMap {
            URL(string: "\(TMDBImage.baseURL)\($0)")
        }
        let year: Int? = Int(String(releaseDate.prefix(4)))
        let formattedRating = ((voteAverage * 100).rounded() / 100 )
        
        return MovieDetailModel(
            title: title,
            rating: formattedRating,
            releaseDate: year,
            overview: overview,
            posterURL: posterURL,
            backdropURL: backdropURL
        )
    }
}

extension MovieDTO {
    
    func toSearchModel(genres: [Int:String]) -> SearchModel {
        let posterURL: URL? = posterPath.flatMap {
            URL(string: "\(TMDBImage.baseURL)\($0)")
        }
        let backdropURL: URL? = backdropPath.flatMap {
            URL(string: "\(TMDBImage.baseURL)\($0)")
        }
        let year: Int? = Int(String(releaseDate.prefix(4)))
        let formattedRating = ((voteAverage * 100).rounded() / 100 )
        let genre = genreIds.first.flatMap { genres[$0]}
        
        return SearchModel(
            id: id,
            posterURL: posterURL,
            title: title,
            releaseYear: year,
            genre: genre,
            rating: formattedRating,
        )
    }
}
