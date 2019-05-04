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
        //TODO: Find out why encoding error when include baseURL
        return URL(string: "https://image.tmdb.org" + posterAPI.path)!
    }

    var overview: String?
    var vote_count: Int

}
