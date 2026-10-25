//
//  Secrets.swift
//  MovieShelf
//
//  Created by Kirill Maidanovich on 26.10.2026.
//

import Foundation

enum Secrets {
    static let accessToken: String = {
        guard let token = Bundle.main.object(forInfoDictionaryKey: "TMDB_TOKEN") as? String, !token.isEmpty else {
            fatalError(ErrorString.tokenError)
        }
        return token
    }()
}
