//
//  SearchView.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 09.10.2026.
//

import SwiftUI

struct SearchView: View {
    @State var viewModel: SearchViewModel
    
    var body: some View {
        NavigationStack {
            TextField("Search movies...", text: $viewModel.text)
                .task(id: viewModel.text) {
                    await viewModel.search()
                }
                .padding()
            
            content
        }
    }
    
    private var content: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                switch viewModel.state {
                case .idle:
                    ProgressView()
                case .loading:
                    Text("Search for the film you'd like to know about")
                case .loaded(let movies):
                    ForEach(movies) { movie in
                        NavigationLink(value: movie.id) {
                            SearchViewCell(searchModel: movie)
                        }
                    }
                case .error(let message):
                    Text(message)
                }
            }
        }
    }
}
