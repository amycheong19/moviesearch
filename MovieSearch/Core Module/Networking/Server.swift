//
//  Server.swift
//  MovieSearch
//
//  Created by Amy Cheong on 2/5/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation

struct Server {
    struct Movie {
        static let baseURL = "api.themoviedb.org"
        static let apiKey = "2a61185ef6a27f400fd92820ad9e8537"
    }

    struct Poster {
        static let baseURL = "​image.tmdb.org"
    }

    struct APIParameterKey {
        static let api = "api_key"
        static let query = "query"
    }
}
