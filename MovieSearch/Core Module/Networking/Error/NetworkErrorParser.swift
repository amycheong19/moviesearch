//
//  NetworkErrorParser.swift
//  MovieSearch
//
//  Created by Amy Cheong on 4/5/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation

protocol NetworkErrorParseable {
    func parse(error: Error) -> NetworkError
}

struct NetworkErrorParser: NetworkErrorParseable {
    func parse(error: Error) -> NetworkError {
        let nsError = error as NSError

        if nsError.isNetworkUnreachableError || nsError.isNetworkConnectionLostError {
            return .offline
        } else if nsError.isCancelledError {
            return .cancelled
        } else {
            return .generic
        }
    }
}

