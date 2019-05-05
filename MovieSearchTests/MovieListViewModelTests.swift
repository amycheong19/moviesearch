//
//  MovieListViewModelTests.swift
//  MovieSearchTests
//
//  Created by Amy Cheong on 5/5/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import XCTest
@testable import MovieSearch

class MovieListTestableModel: MovieListViewModel {

    override var movieService: MovieService {
        return MockMovieService()
    }
}

class MovieListViewModelTests: XCTestCase {
    var viewModel: MovieListTestableModel = MovieListTestableModel()
    let expectation = XCTestExpectation()

    // Normal list loading
    func testGetMovieListWithRightQuery() {
        viewModel.tableDataHandler = { [weak self] result in
            

            XCTAssertEqual(result.movies.count, 20)
            self?.expectation.fulfill()
        }

        viewModel.getMovie(by: "Hom", reset: true)
        wait(for: [expectation], timeout: 10.0)
    }

    // Empty query should return empty list
    func testGetMovieListWithEmptyQuery() {
        viewModel.tableDataHandler = { [weak self] result in
            XCTAssertEqual(result.movies.count, 0)
            self?.expectation.fulfill()
        }

        viewModel.getMovie(by: "", reset: true)
        wait(for: [expectation], timeout: 10.0)
    }

    // Test when user scroll to the bottom and load the next page
    func testGetMovieListLoadMore() {
        // Check if the list is added for the second time.
        var getMovieCount = 0
        viewModel.tableDataHandler = { [weak self] result in
            getMovieCount += 1
            if getMovieCount == 2 {
                // It's going to be the double count since we are using mock
                XCTAssertEqual(result.movies.count, 40)
                self?.expectation.fulfill()
            }
        }

        viewModel.getMovie(by: "Hom", reset: true)
        viewModel.getMovie(by: "Hom", reset: false)
        wait(for: [expectation], timeout: 10.0)
    }


    func testGetImageForMovie() {
        let rowIndexPath = IndexPath(row: 1, section: 1)
        viewModel.loadImageDataHandler = { [weak self] (imageDataAndIndexPath) in
            XCTAssertNotNil(imageDataAndIndexPath.data)
            XCTAssertEqual(imageDataAndIndexPath.indexPath, rowIndexPath)
            self?.expectation.fulfill()
        }

        // We are using the sample url for testing
        viewModel.getImage(with: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/359bHILkiD6ZVCq6WoHSD0UuJQV.jpg")!,
                           indexPath: rowIndexPath)
        wait(for: [expectation], timeout: 10.0)

    }
}
