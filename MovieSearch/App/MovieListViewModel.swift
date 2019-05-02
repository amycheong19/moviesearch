//
//  MovieListViewModel.swift
//  MovieSearch
//
//  Created by Amy Cheong on 30/4/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation

class MovieListViewModel {
    private(set) var movieService = MovieService()

    var tableDataHandler: (([Movie]) -> ())?
    private(set) var movieList: [Movie] = [] {
        didSet { tableDataHandler?(movieList) }
    }

    init() {
        getMovie(by: "Harry Potter")
    }

    func getMovie(by query: String) {
        movieService.getMovieDetails(query: query) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let list):
                guard let list = list else { return }
                self.movieList = list.results
            case .error(let error):
                debugPrint(error)
            }
        }
    }
}
