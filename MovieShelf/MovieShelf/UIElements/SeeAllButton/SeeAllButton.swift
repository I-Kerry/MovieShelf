//
//  SeeAllButton.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 25.08.2026.
//

import SwiftUI

struct SeeAllButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(Titles.seeAllButton)
                .font(.callout)
                .foregroundStyle(.blue)
        }
    }
}
