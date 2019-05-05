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

    // Handle movie list
    typealias GetMovieListResult = (movies: [Movie], error: Error?)
    var tableDataHandler: ((GetMovieListResult) -> ())?
    private(set) var moviesResult: GetMovieListResult = ([], nil) {
        didSet { tableDataHandler?(moviesResult) }
    }

    // Handle footer loading
    var loadingDataHandler: ((Bool) -> ())?
    private(set) var loadingData: Bool = false {
        didSet { loadingDataHandler?(loadingData) }
    }

    // Handle image caching
    var imageCache: NSCache<AnyObject, AnyObject>! = NSCache()
    var loadImageDataHandler: (((data: Data?, indexPath: IndexPath?)) -> ())?
    private(set) var imageDataAndIndexPath: (Data?, IndexPath?) = (nil, nil) {
        didSet { loadImageDataHandler?(imageDataAndIndexPath) }
    }

    /**
       Curate a list of movies

     - Parameter query: Searchbar query words
     - Parameter reset: Reset movies and load a new list or to append it
     */
    func getMovie(by query: String, reset: Bool = true) {
        guard query.count > 0 else {
            loadingData = false
            moviesResult = ([], nil)
            movieList = nil
            movieService.movieDetailDataTask?.cancel()
            return
        }

        // Stop searching when nextPage < movieList.totalPage
        // We don't want to have too many API calls
        var nextPage = 1
        if let movieList = movieList, reset == false {
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
                self.movieList = list
                let movies = list?.results ?? []
                self.moviesResult = reset ? (movies, nil) : (self.moviesResult.movies + movies, nil)
            case .error(let error):
                switch error {
                case NetworkError.cancelled: break
                default:
                    // We need to ignore cancel loading error if
                    // searchbar changes when we start searching
                    self.loadingData = false
                    self.moviesResult = ([], error)
                }
            }
        }
    }

    /**
     Get image for each movie poster

     - Parameter url: Movie poster path URL
     */
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
