//
//  MoviePreviewCell.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 25.08.2026.
//

import SwiftUI

private enum Constants {
    static let height: CGFloat = 140
    static let width: CGFloat = 92
    static let textHeight: CGFloat = 50
    static let lineLimit = 2
}

struct MoviePreviewCell: View {
    let model: MoviePreviewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: Constraints.smallerSpacing) {
            AsyncImage(url: model.posterURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: Constants.width, height: Constants.height)
                    .clipShape(RoundedRectangle(cornerRadius: Constraints.cornerRadius))
            } placeholder: { ProgressView() }
            
            Text(model.name)
                .font(.title3)
                .foregroundStyle(.textMade)
                .lineLimit(Constants.lineLimit)
                .multilineTextAlignment(.leading)
                .frame(width: Constants.width, height: Constants.textHeight)
            
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
            .frame(width: Constants.width)
        }
        .frame(width: Constants.width)
    }
}
