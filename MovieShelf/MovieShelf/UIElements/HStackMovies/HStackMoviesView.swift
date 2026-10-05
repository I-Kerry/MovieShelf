//
//  HStackMovies.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 25.08.2026.
//

import SwiftUI

private enum Constants {
    static let stackFrame: CGFloat = 250
}

struct HStackMoviesView: View {
    let title: String
    let movies: [MoviePreviewModel]
    
    var body: some View {
        VStack(spacing: Constraints.smallerSpacing) {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.textMade)
                Spacer()
                SeeAllButton {
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: Constraints.smallestSpacing) {
                    ForEach(movies) { movie in
                        MoviePreviewCell(model: movie)
                    }
                }
                .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: Constants.stackFrame)
    }
}
