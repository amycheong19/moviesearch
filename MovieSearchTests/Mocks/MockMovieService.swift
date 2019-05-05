//
//  MockMovieService.swift
//  MovieSearchTests
//
//  Created by Amy Cheong on 5/5/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation
@testable import MovieSearch

class MockMovieService: MovieService {

    let mockURL = URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/359bHILkiD6ZVCq6WoHSD0UuJQV.jpg")!

    override func getMovieDetails(query: String, page: Int, completion: @escaping (Result<MovieList>) -> Void) {
        let movieListResponse: MovieList? = readJsonData(with: "MockableGetMoviesJson")
        guard let response = movieListResponse else {
            return completion(.error(APIError.parseError))
        }
        return completion(.success(response))
    }

    override func downloadPoster(url: URL, completion: @escaping (Result<Data>) -> Void) {
        return NetworkLayer().download(url: mockURL, completion: completion)
    }
}
