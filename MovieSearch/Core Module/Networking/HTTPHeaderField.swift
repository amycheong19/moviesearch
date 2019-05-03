//
//  HTTPHeaderField.swift
//  MovieSearch
//
//  Created by Amy Cheong on 1/5/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation

public enum ContentType: String {
    case formUrlEncoded = "application/x-www-form-urlencoded"
    case json = "application/json"
}

public enum HttpHeaderField {
    case accept(ContentType)
    case contentType(ContentType)

    public var key: String {
        switch self {
        case .accept: return "Accept"
        case .contentType: return "Content-Type"
        }
    }

    public var value: String {
        switch self {
        case let .accept(contentType): return contentType.rawValue
        case let .contentType(contentType): return contentType.rawValue
        }
    }
}

public extension URLRequest {
    mutating func adding(headerField: HttpHeaderField) {
        addValue(headerField.value, forHTTPHeaderField: headerField.key)
    }

    mutating func adding(headerFields: [HttpHeaderField]) {
        headerFields.forEach {
            self.addValue($0.value, forHTTPHeaderField: $0.key)
        }
    }
}

