//
//  MovieServiceTests.swift
//  MovieSearchTests
//
//  Created by Amy Cheong on 5/5/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import XCTest
@testable import MovieSearch

class MovieServiceTests: XCTestCase {

    let movieService = MockMovieService()
    let expectation = XCTestExpectation()

    func testGetMovies() {
        movieService.getMovieDetails(query: "", page: 1) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let list):
                guard let _ = list else { return }
                self.expectation.fulfill()
            default: break
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testDownloadPoster() {
        movieService.downloadPoster(url: movieService.mockURL) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let data):
                guard let _ = data else { return }
                self.expectation.fulfill()
            default: break
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
