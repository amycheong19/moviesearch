//
//  Movie.swift
//  MovieSearch
//
//  Created by Amy Cheong on 2/5/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var id: Int
    var title: String
    var poster_path: String?
    var posterLink: URL? {
        guard let path = poster_path else { return nil }
        let posterAPI = MovieAPI.getPoster(file: path)
        return posterAPI.asURLRequest().url
    }

    var overview: String?
    var vote_count: Int

}
