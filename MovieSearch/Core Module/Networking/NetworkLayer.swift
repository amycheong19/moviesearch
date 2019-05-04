//
//  NetworkLayer.swift
//  Property
//
//  Created by Amy Cheong on 16/2/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T?)
    case error(Error)
}

class NetworkLayer {
    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return urlResponse.statusCode >= 200 && urlResponse.statusCode < 300
    }
    
    func get<ExpectedResult: Codable>(request: URLRequest,
                                      completion: @escaping (Result<ExpectedResult>) -> Void) -> URLSessionDataTask {
        
        func fail(error: Error) {
            DispatchQueue.main.async {
                completion(.error(error))
            }
        }
        
        func success(data: ExpectedResult) {
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                let networkError = NetworkErrorParser().parse(error: error)
                fail(error: networkError)
                return
            }
            
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    debugPrint("Unable to parse the response in given type \(ExpectedResult.self)")
                    return fail(error: APIError.parseError)
                }
                
                if let responseObject = try? JSONDecoder().decode(ExpectedResult.self, from: data) {
                    success(data: responseObject)
                    return
                }
            }

            fail(error: NetworkError.generic)
        }
        task.resume()
        
        return task
    }

    func download(url: URL, completion: @escaping (Result<Data>) -> Void) {
        func fail(error: Error) {
            DispatchQueue.main.async {
                completion(.error(error))
            }
        }

        func success(data: Data) {
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }

        let session = URLSession.shared
        let task = session.downloadTask(with: url) { (data, urlResponse, error) in
            if let error = error {
                let networkError = NetworkErrorParser().parse(error: error)
                fail(error: networkError)
                return
            }

            if self.isSuccessCode(urlResponse) {
                guard let data = try? Data(contentsOf: url) else {
                    return fail(error: NetworkError.generic)
                }
                success(data: data)
                return
                
            }

            fail(error: NetworkError.generic)
        }
        task.resume()

    }
}
