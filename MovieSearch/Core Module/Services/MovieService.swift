//
// 
//
//  Created by Amy Cheong on 16/2/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation

protocol APIConfiguration {
    var method: HTTPMethod { get }
    var path: String { get }
    var query: [URLQueryItem] { get }
}

enum MovieAPI: APIConfiguration {
    case getDetails(query: String, page: Int)
    case getPoster(file: String)

    var baseURL: String {
        switch self {
        case .getDetails:
            return Server.Movie.baseURL
        case .getPoster:
            return Server.Poster.baseURL
        }
    }

    var path: String {
        switch self {
        case .getDetails:
            return "/3/search/movie"
        case .getPoster(let file):
            return "/t/p/w600_and_h900_bestv2\(file)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getDetails, .getPoster:
            return .get
        }
    }

    var query: [URLQueryItem] {
        switch self {
        case .getDetails(let query, let page):
            let queryItemAPI = URLQueryItem(name: Server.APIParameterKey.api,
                                              value: Server.Movie.apiKey)
            let queryItemQuery = URLQueryItem(name: Server.APIParameterKey.query,
                                              value: query)
            let queryItemPage = URLQueryItem(name: Server.APIParameterKey.page,
                                              value: "\(page)")

            return [queryItemAPI, queryItemQuery, queryItemPage]
        case .getPoster:
            return []
        }
    }
    
    var headers: [HttpHeaderField] {
        return [HttpHeaderField.contentType(ContentType.json)]
    }

    func asURLRequest() -> URLRequest {
        let url = UrlBuilder(host: baseURL, path: path, query: query).buildUrl()
        let urlRequest = JsonBodyUrlRequestBuilder(httpMethod: method,
                                                   httpHeaders: headers,
                                                   url: url).buildUrlRequest()

        return urlRequest
    }
}

class MovieService {
    var movieDetailDataTask: URLSessionDataTask?
    func getMovieDetails(query: String, page: Int,
                         completion: @escaping (Result<MovieList>) -> Void) {
        movieDetailDataTask?.cancel()
        movieDetailDataTask = NetworkLayer().get(request: MovieAPI.getDetails(query: query,
                                                               page: page).asURLRequest(),
                                  completion: completion)
    }

    func downloadPoster(url: URL, completion: @escaping (Result<Data>) -> Void) {
       return NetworkLayer().download(url: url, completion: completion)
    }
}

