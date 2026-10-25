//
//  GenreView.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 24.10.2026.
//

import SwiftUI

struct GenreView: View {
    @Binding var selectedGenre: Genre?
    let genres: [Genre]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Constraints.smallestSpacing) {
                ForEach(GenreMock.allGenres, id: \.id) { genre in
                    Button {
                        if selectedGenre == genre {
                            selectedGenre = nil
                        } else {
                            selectedGenre = genre
                        }
                    } label: {
                        Text(genre.name)
                            .font(.subheadline)
                            .padding(.horizontal, Constraints.usualSpacing)
                            .padding(.vertical, Constraints.smallerSpacing)
                            .background(Capsule().fill(selectedGenre == genre ? Color.blue : Color.blue.opacity(Opacity.lowOpacity)))
                            .foregroundStyle(selectedGenre == genre ? .white : .blue)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
    }
}
