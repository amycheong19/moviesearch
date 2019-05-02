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
                                     completion: @escaping (Result<ExpectedResult>) -> Void) {

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

      URLSession.shared.dataTask(with: request){ (data, urlResponse, error) in
         if let error = error {
            print(error.localizedDescription)
            fail(error: Error.generic)
            return
         }

         if self.isSuccessCode(urlResponse) {
            guard let data = data else {
               print("Unable to parse the response in given type \(ExpectedResult.self)")
               return fail(error: Error.generic)
            }

            if let responseObject = try? JSONDecoder().decode(ExpectedResult.self, from: data) {
               success(data: responseObject)
               return
            }
         }
         fail(error: Error.generic)
      }.resume()
   }

    func post<ExpectedResult: Codable>(request: URLRequest,
                                      body: ExpectedResult,
                                      completion: @escaping (Result<ExpectedResult>) -> Void) {

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

      var request = request
      guard let data = try? JSONEncoder().encode(body) else {
         return fail(error: Error.parseError)
      }
      request.httpBody = data
      URLSession.shared.uploadTask(with: request,
                                   from: data) { (data, urlResponse, error) in
                                    if self.isSuccessCode(urlResponse) {
                                       guard let data = data else {
                                          print("Unable to parse the response in given type \(ExpectedResult.self)")
                                          return fail(error: Error.generic)
                                       }
                                       if let responseObject = try? JSONDecoder().decode(ExpectedResult.self, from: data) {
                                          success(data: responseObject)
                                          return
                                       }
                                    }
                                    fail(error: Error.generic)
         }.resume()
   }

}
