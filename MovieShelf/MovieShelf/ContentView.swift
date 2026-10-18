//
//  ContentView.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 24.08.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var service: TMDBService
    var body: some View {
        TabView {
            
            Tab("", systemImage: Icons.home) {
                NavigationStack {
                    HomePageView(viewModel: HomePageViewModel(service: service))
                }
            }
            Tab("", systemImage: Icons.magnifyingGlass) {
                SearchView(viewModel: SearchViewModel(service: service))
            }
            Tab("", systemImage: Icons.wishlist) {
                WatchListView(service: service)
            }
        }
    }
}

#Preview {
    ContentView(service: TMDBService())
}
