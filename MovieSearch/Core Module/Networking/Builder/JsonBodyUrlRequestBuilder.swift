//
//  JsonBodyUrlRequestBuilder.swift
//  MovieSearch
//
//  Created by Amy Cheong on 2/5/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation

struct JsonBodyUrlRequestBuilder {
    private let httpMethod: HTTPMethod
    private let url: URL
    private let data: Data?
    private let httpHeaders: [HttpHeaderField]

    init(httpMethod: HTTPMethod,
         httpHeaders: [HttpHeaderField],
         url: URL,
         data: Data? = nil) {
        self.httpMethod = httpMethod
        self.url = url
        self.data = data
        self.httpHeaders = httpHeaders
    }

    func buildUrlRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.adding(headerFields: httpHeaders)
        request.httpBody = data
        return request
    }
}
