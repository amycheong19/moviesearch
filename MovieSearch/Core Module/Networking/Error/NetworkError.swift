//
//  NetworkError.swift
//  MovieSearch
//
//  Created by Amy Cheong on 30/4/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation

extension NSError {
    var isCancelledError: Bool {
        return code == NSURLErrorCancelled
    }

    var isNetworkUnreachableError: Bool {
        return isNetworkError && code == NSURLErrorNotConnectedToInternet
    }

    var isNetworkTimeoutError: Bool {
        return isNetworkError && code == NSURLErrorTimedOut
    }

    var isNetworkConnectionLostError: Bool {
        return isNetworkError && code == NSURLErrorNetworkConnectionLost
    }

    var isNetworkError: Bool {
        return domain == NSURLErrorDomain
    }
}

public enum NetworkError: Error {
    case offline
    case cancelled
    case generic
}

