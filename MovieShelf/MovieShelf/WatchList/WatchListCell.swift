//
//  WatchListCell.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 16.10.2026.
//

import SwiftUI

struct WatchListCell: View {
    let item: SDWatchListItem
    var body: some View {
        VStack(alignment: .leading, spacing: Constraints.smallerSpacing) {
            poster
            info
        }
    }
    
    @ViewBuilder
    private var poster: some View {
        ZStack {
            Color.gray.opacity(0.5)
                .aspectRatio(contentMode: .fill)
            if let url = item.posterURL.flatMap(URL.init(string:)) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty: ProgressView()
                    case .success(let image):
                        image.resizable()
                            .scaledToFill()
                    case .failure: Image(systemName: "photo")
                    @unknown default: EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
            }
        }
        .frame(width: 170, height: 250)
        .clipShape(RoundedRectangle(cornerRadius: Constraints.cornerRadius))
    }
    
    private var info: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.title)
                .font(.body)
            
            HStack(spacing: 4) {
                if let rating = item.voteAverage {
                    Text("★ \(String(format: "%.1f", rating))")
                        .font(.caption)
                        .foregroundStyle(.yellow)
                    
                    if item.voteAverage != nil {
                        Circle()
                            .frame(width: 5, height: 5)
                    }
                }
                if let releaseDate = item.releaseDate {
                    Text(String(releaseDate))
                        .font(.caption)
                }
            }
        }
    }
}

#Preview {
    WatchListCell(item: SDWatchListItem(id: 1, title: "Lox",voteAverage: 8.1, releaseDate: 2025  ,addedAt: .now))
}
