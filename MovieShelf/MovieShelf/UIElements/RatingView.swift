//
//  RatingView.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 30.08.2026.
//

import SwiftUI


struct RatingView: View {
    
    private enum Constants {
        static let size: CGFloat = 10
        static let spacing: CGFloat = 4
        static let iconName = "star.fill"
    }
    
    let rating: Float
    var body: some View {
        HStack(spacing: Constants.spacing) {
            Image(systemName: Constants.iconName)
                .font(.system(size: Constants.size))
                .foregroundStyle(.yellow)
            Text(String(rating))
                .font(.caption)
                .foregroundStyle(.yellow)
        }
    }
}
