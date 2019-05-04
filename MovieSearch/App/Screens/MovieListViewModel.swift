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
    private var movieList: MovieList?

    var tableDataHandler: (([Movie]) -> ())?
    private(set) var movies: [Movie] = [] {
        didSet { tableDataHandler?(movies) }
    }

    func getMovie(by query: String, reset: Bool = true) {
        guard query.count != 0  else {
            self.movies = []
            movieList = nil
            return
        }

        if reset {
            movieList = nil
            movies = []
        }


        // Stop searching when nextPage < movieList.totalPage
        // We don't want to have too many API calls
        var nextPage = 1
        if let movieList = movieList {
            nextPage = movieList.page + 1
            if nextPage > movieList.total_pages { return }
        }

        movieService.getMovieDetails(query: query, page: nextPage) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let list):
                guard let list = list else { return }
                self.movieList = list
                self.movies += list.results

            case .error(let error):
                debugPrint(error)
            }
        }
    }
}
