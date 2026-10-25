//
//  MoviePreviewCell.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 25.08.2026.
//

import SwiftUI

struct MoviePreviewCell: View {
    let model: MoviePreviewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: Constraints.smallerSpacing) {
            AsyncImage(url: model.posterURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: HStackMoviesSizes.cellWidth, height: HStackMoviesSizes.cellHeight)
                    .clipShape(RoundedRectangle(cornerRadius: Constraints.cornerRadius))
            } placeholder: { ProgressView() }
            
            Text(model.name)
                .font(.title3)
                .foregroundStyle(.textMade)
                .lineLimit(Limits.lineLimit)
                .multilineTextAlignment(.leading)
                .frame(width: HStackMoviesSizes.cellWidth, height: HStackMoviesSizes.cellHeight)
            
            HStack(spacing: Constraints.smallerSpacing) {
                Text(String(model.year))
                    .font(.caption2)
                    .foregroundStyle(.gray)
                
                Spacer()
                    .frame(width: .leastNonzeroMagnitude)
                
                Text(String(model.rating))
                    .font(.caption2)
                    .foregroundStyle(.yellow)
            }
            .frame(width: HStackMoviesSizes.cellWidth)
        }
        .frame(width: HStackMoviesSizes.cellWidth)
    }
}

#Preview {
    MoviePreviewCell(model: MoviePreviewModel(
        id: 1, posterURL: nil, name: "idk", year: 2009, rating: 1.9, genre: nil))
}
