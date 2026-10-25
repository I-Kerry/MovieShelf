//
//  MainPageImageView.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 29.08.2026.
//

import SwiftUI

struct MainPageImageView: View {
    
    let imageURL: URL?
    let title: String
    let year: Int
    let genre: String?
    let rating: Float
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color.textMade
                .clipShape(RoundedRectangle(cornerRadius: Constraints.cornerRadius))
            AsyncImage(url: imageURL, content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: MainPageImageViewSize.height)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: Constraints.cornerRadius))
            }, placeholder: {
                ProgressView()
            })
                
            LinearGradient(
                colors: [.clear, .black.opacity(Opacity.highOpacity)],
                startPoint: .center,
                endPoint: .bottom)
            .clipShape(RoundedRectangle(cornerRadius: Constraints.cornerRadius))

            VStack(alignment: .leading, spacing: Constraints.smallerSpacing) {
                Spacer()
                Text(title)
                    .font(.title)
                    .foregroundStyle(.white)
                
                HStack(spacing: Constraints.smallerSpacing) {
                    Text(String(year))
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    divider
                    Text(genre ?? "")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    divider
                    RatingView(rating: rating)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, Constraints.spacing)
        }
        .frame(height: MainPageImageViewSize.height)
        .frame(maxWidth: .infinity)
    }
    
    var divider: some View {
        Circle()
            .frame(width: DividerItemsFrame.mainPageDividerWidth, height: DividerItemsFrame.mainPageDividerHeight)
            .foregroundStyle(.gray)
    }
}
