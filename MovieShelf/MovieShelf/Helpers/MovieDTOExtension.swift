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
            posterURL: posterURL,
            name: title,
            year: year,
            rating: formattedRating,
            genre: nil
        )
    }
    
//    func fromMainPageView(model: MoviePreviewModel) -> MainPageImageView {
//        MainPageImageView(imageURL: model.posterURL, title: model.name, year: model.year, genre: model.genre, rating: Float(model.rating))
//    }
}
