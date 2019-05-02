//
//  NetworkError.swift
//  MovieSearch
//
//  Created by Amy Cheong on 30/4/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation

public enum Error: Swift.Error {
    case generic

    case parseError
    case jsonEcodingError

    var title: String {
        switch self {
        case .parseError:
            return "Oops"
        default:
            return "Error"
        }
    }

    var message: String {
        switch self {
        case .parseError:
            return "Cannot parse given object"
        default:
            return "Something went wrong. Please try again later"

        }
    }
}
