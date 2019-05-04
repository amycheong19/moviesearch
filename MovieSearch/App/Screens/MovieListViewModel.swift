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

    var loadingDataHandler: ((Bool) -> ())?
    private(set) var loadingData: Bool = false {
        didSet { loadingDataHandler?(loadingData) }
    }

    var imageCache: NSCache<AnyObject, AnyObject>! = NSCache()
    var loadImageDataHandler: ((Data?, IndexPath?) -> ())?
    private(set) var imageDataAndIndexPath: (Data?, IndexPath?) = (nil, nil) {
        didSet { loadImageDataHandler?(imageDataAndIndexPath.0, imageDataAndIndexPath.1) }
    }


    func getMovie(by query: String, reset: Bool = true) {
        guard query.count != 0 else {
            self.movies = []
            movieList = nil
            self.loadingData = false
            return
        }

        // When searchbar changes, reset the list
        if reset {
            movieList = nil
            movies = []
        }

        // Stop searching when nextPage < movieList.totalPage
        // We don't want to have too many API calls
        var nextPage = 1
        if let movieList = movieList {
            nextPage = movieList.page + 1
            if nextPage > movieList.total_pages {
                loadingData = false
                return
            }
        }

        loadingData = true
        movieService.getMovieDetails(query: query, page: nextPage) { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let list):
                self.loadingData = false
                guard let list = list else { return }
                self.movieList = list
                self.movies += list.results
            case .error(let error):
                switch error {
                case NetworkError.cancelled: break
                default:
                    // We need to ignore cancel loading error if
                    // searchbar changes when we start searching
                    self.loadingData = false
                }
            }
        }
    }


    func getImage(with url: URL, indexPath: IndexPath) {
        movieService.downloadPoster(url: url) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self.imageDataAndIndexPath = (data, indexPath)
                self.imageCache.setObject(data as AnyObject, forKey: url as AnyObject)
                
            case .error(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}
