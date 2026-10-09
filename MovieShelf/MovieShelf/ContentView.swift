//
//  ContentView.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 24.08.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            
            Tab("", systemImage: Icons.home) {
                NavigationStack {
                    HomePageView(viewModel: HomePageViewModel(service: TMDBService()))
                }
            }
            Tab("", systemImage: Icons.magnifyingGlass) {
                SearchView(viewModel: SearchViewModel(service: TMDBService()))
            }
            Tab("", systemImage: Icons.wishlist) {
//                HomePageView()
            }
        }
    }
}

#Preview {
    ContentView()
}
