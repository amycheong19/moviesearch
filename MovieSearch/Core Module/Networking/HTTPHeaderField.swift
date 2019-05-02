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
    case acceptLanguage(String)
    case authorization(String)
    case contentType(ContentType)

    public var key: String {
        switch self {
        case .acceptLanguage: return "Accept-Language"
        case .authorization: return "Authorization"
        case .contentType: return "Content-Type"
        }
    }

    public var value: String {
        switch self {
        case let .authorization(token): return token.isEmpty ? "" : "Bearer \(token)"
        case let .acceptLanguage(language): return language
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

