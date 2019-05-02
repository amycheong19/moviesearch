//
//  Movie.swift
//  MovieSearch
//
//  Created by Amy Cheong on 2/5/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var title: String
    var poster_path: String?
    var overview: String?

    init(title: String, poster: String?, overview: String?) {
        self.title = title
        self.poster_path = poster
        self.overview = overview
    }
}
