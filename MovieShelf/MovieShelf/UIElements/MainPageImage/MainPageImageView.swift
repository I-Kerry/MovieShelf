//
//  MainPageImageView.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 29.08.2026.
//

import SwiftUI

struct MainPageImageView: View {
    
    private enum Constants {
        static let height: CGFloat = 210
        static let cornerRadius: CGFloat = 16
        static let opacity = 0.7
        static let spacing: CGFloat = 6
        static let padding: CGFloat = 16
        static let dividerHeight: CGFloat = 16
        static let dividerWidth: CGFloat = 8
    }
    
    let imageURL: URL?
    let title: String
    let year: Int
    let genre: String?
    let rating: Float
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color.textMade
            AsyncImage(url: imageURL, content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: Constants.height)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
            }, placeholder: {
                ProgressView()
            })
                
            LinearGradient(
                colors: [.clear, .black.opacity(Constants.opacity)],
                startPoint: .center,
                endPoint: .bottom)
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))

            VStack(alignment: .leading, spacing: Constants.spacing) {
                Spacer()
                Text(title)
                    .font(.title)
                    .foregroundStyle(.white)
                
                HStack(spacing: Constants.spacing) {
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
            .padding(.bottom, Constants.padding)
        }
        .frame(height: Constants.height)
        .frame(maxWidth: .infinity)
    }
    
    var divider: some View {
        Circle()
            .frame(width: Constants.dividerWidth, height: Constants.dividerHeight)
            .foregroundStyle(.gray)
    }
}
