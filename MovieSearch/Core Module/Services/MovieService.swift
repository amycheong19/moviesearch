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
    case getDetails(query: String)
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
            return "/t/p/w600_and_h900_bestv2/\(file)"
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
        case .getDetails(let query):
            let queryItemAPI = URLQueryItem(name: Server.APIParameterKey.api,
                                              value: Server.Movie.apiKey)
            let queryItemQuery = URLQueryItem(name: Server.APIParameterKey.query,
                                              value: query)
            return [queryItemAPI, queryItemQuery]
        case .getPoster:
            return []
        }
    }

    var sampleData: Data? {
        switch self {
        case .getDetails:
            return "{\"\(Server.APIParameterKey.api)\": \(Server.Movie.apiKey), \"\(Server.APIParameterKey.query)\": \"Harry%20Potter\"}".utf8Encoded
        case .getPoster:
            return nil
        }
    }
    
    var headers: [HttpHeaderField] {
        return [HttpHeaderField.contentType(ContentType.json)]
    }

    func asURLRequest() -> URLRequest {
        let url = UrlBuilder(host: baseURL, path: path, query: query).buildUrl()!
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601

        let urlRequest = JsonBodyUrlRequestBuilder(httpMethod: method,
                                                   httpHeaders: headers,
                                                   url: url).buildUrlRequest()
        return urlRequest
    }
}

class MovieService {

    func getMovieDetails(query: String, completion: @escaping (Result<MovieList>) -> Void) {
       return NetworkLayer().get(request: MovieAPI.getDetails(query: query).asURLRequest(), completion: completion)
    }

    func getPoster(file: String, completion: @escaping (Result<[String]>) -> Void) {
        return NetworkLayer().get(request: MovieAPI.getPoster(file: file).asURLRequest(), completion: completion)
    }

}

