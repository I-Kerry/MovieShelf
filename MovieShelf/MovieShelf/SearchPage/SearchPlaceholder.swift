//
//  SearchPlaceholder.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 14.10.2026.
//

import SwiftUI

struct SearchPlaceholder: View {
    var body: some View {
        Spacer()
        Text("Search for the film you'd like to know about")
            .font(.title2)
            .fontDesign(.rounded)
            .multilineTextAlignment(.center)
        Spacer()
    }
}
