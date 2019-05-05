//
//  MovieList.swift
//  MovieSearch
//
//  Created by Amy Cheong on 2/5/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation

struct MovieList: Codable {
    var page: Int
    var total_results: Int
    var total_pages: Int
    var results: [Movie]
}
