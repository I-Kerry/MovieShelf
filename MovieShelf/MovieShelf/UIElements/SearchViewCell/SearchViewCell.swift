//
//  SearchViewCell.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 09.10.2026.
//

import SwiftUI

struct SearchViewCell: View {
    let searchModel: SearchModel
    
    var body: some View {
        HStack {
            AsyncImage(url: searchModel.posterURL) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .clipShape(RoundedRectangle(cornerRadius: Constraints.cornerRadius))
                default:
                    Color.gray.opacity(0.3)
                        .clipShape(RoundedRectangle(cornerRadius: Constraints.cornerRadius))
                }
            }
            .frame(width: 70, height: 105)
            
            VStack(alignment: .leading, spacing: Constraints.spacing) {
                Text(searchModel.title)
                    .font(.headline)
                HStack {
                    Group {
                        if let year = searchModel.releaseYear {
                            Text(String(year))
                        }
                        Text("·")
                        Text(searchModel.genre ?? "")
                    }
                    .font(.callout)
                    .foregroundStyle(.secondary)
                }
                if let rating = searchModel.rating {
                    Text(String(format: "%.1f", rating))
                        .font(.title3)
                        .foregroundStyle(.yellow)
                } else {
                    Text("Not rated yet")
                }
            }
            .padding()
            
            Spacer()
        }
        .frame(height: 104)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.backgroundMade)
        .clipShape(RoundedRectangle(cornerRadius: Constraints.cornerRadius))
    }
}

#Preview {
    SearchViewCell(searchModel: SearchModel(id: 1, posterURL: nil ,title: "lol", releaseYear: 1999, genre: "action", rating: 3.4))
}
