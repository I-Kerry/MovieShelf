//
//  WatchListCell.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 16.10.2026.
//

import SwiftUI

struct WatchListCell: View {
    @State private var reloadToken = UUID()
    let item: SDWatchListItem
    var body: some View {
        VStack(alignment: .leading, spacing: Constraints.smallerSpacing) {
            poster
            info
        }
        .onAppear { reloadToken = UUID() }
    }
    
    @ViewBuilder
    private var poster: some View {
        ZStack {
            Color.gray.opacity(Opacity.highOpacity)
                .aspectRatio(contentMode: .fill)
            if let url = item.posterURL.flatMap(URL.init(string:)) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty: ProgressView()
                    case .success(let image):
                        image.resizable()
                            .scaledToFill()
                    case .failure: Image(systemName: Icons.photo)

                    @unknown default: EmptyView()
                    }
                }
                .id(reloadToken)
            } else {
                Image(systemName: Icons.photo)
            }
        }
        .frame(width: WatchListImageFrame.width, height: WatchListImageFrame.height)
        .clipShape(RoundedRectangle(cornerRadius: Constraints.cornerRadius))
    }
    
    private var info: some View {
        VStack(alignment: .leading, spacing: Constraints.smallestSpacing) {
            Text(item.title)
                .font(.body)
                .lineLimit(Limits.lineLimit, reservesSpace: true)
            
            HStack(spacing: Constraints.smallestSpacing) {
                if let rating = item.voteAverage, rating > 0 {
                    Text("★ \(String(format: "%.1f", rating))")
                        .font(.caption)
                        .foregroundStyle(.yellow)
                } else {
                    Text("N/A")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                
                if item.voteAverage != nil,
                   item.releaseDate != nil {
                    Circle()
                        .frame(width: DividerItemsFrame.frameSize, height: DividerItemsFrame.frameSize)
                }
                
                if let releaseDate = item.releaseDate {
                    Text(String(releaseDate).prefix(Limits.datePrefix))
                        .font(.caption)
                }
            }
        }
    }
}

#Preview {
    WatchListCell(item: SDWatchListItem(id: 1, title: "Lox",voteAverage: 8.1, releaseDate: 2025  ,addedAt: .now))
}
