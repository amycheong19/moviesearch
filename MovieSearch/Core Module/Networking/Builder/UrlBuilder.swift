//
//  UrlBuilder.swift
//  MovieSearch
//
//  Created by Amy Cheong on 2/5/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation

struct UrlBuilder {
    let host: String
    let path: String
    let query: [URLQueryItem]

    init(host: String, path: String, query: [URLQueryItem] = []) {
        self.host = host
        self.path = path
        self.query = query
    }

    func buildUrl() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = !query.isEmpty ? query : nil

        let formattedString = components.url!.absoluteString
        return URL(string: formattedString)!
    }
}
