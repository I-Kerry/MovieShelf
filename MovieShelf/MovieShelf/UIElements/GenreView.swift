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
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Capsule().fill(selectedGenre == genre ? Color.blue : Color.blue.opacity(0.2)))
                            .foregroundStyle(selectedGenre == genre ? .white : .blue)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
    }
}
