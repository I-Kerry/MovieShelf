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
            
            VStack(alignment: .leading, spacing: 4) {
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
                Text(String(format: "%.1f", searchModel.rating))
                    .font(.title3)
                    .foregroundStyle(.yellow)
            }
            .padding()
            
            Spacer()
        }
        .frame(height: 104)
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    SearchViewCell(searchModel: SearchModel(id: 1, posterURL: nil ,title: "lol", releaseYear: 1999, genre: "action", rating: 3.4))
}
