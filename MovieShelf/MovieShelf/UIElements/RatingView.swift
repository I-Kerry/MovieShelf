//
//  RatingView.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 30.08.2026.
//

import SwiftUI


struct RatingView: View {

    let rating: Float
    private var displayRating: String {
        rating > 0 ? String(format: "%.1f", rating) : "N/A"
    }

    var body: some View {
        HStack(spacing: Constraints.smallestSpacing) {
            Image(systemName: Icons.star)
                .font(.system(size: DividerItemsFrame.ratingSize))
                .foregroundStyle(.yellow)
            Text(displayRating)
                .font(.caption)
                .foregroundStyle(.yellow)
        }
    }
}
