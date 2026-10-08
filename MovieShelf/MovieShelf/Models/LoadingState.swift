//
//  LoadingState.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 09.10.2026.
//

import Foundation

enum LoadingState<T> {
    case idle
    case loading
    case loaded(T)
    case error(String)
}
