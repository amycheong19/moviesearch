//
//  ReadJson.swift
//  MovieSearchTests
//
//  Created by Amy Cheong on 5/5/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation

func readJsonData<ExpectedResult: Codable>(with filename: String) -> ExpectedResult? {
    do {
        if let file = Bundle.main.url(forResource: filename, withExtension: "json") {
            let data = try Data(contentsOf: file)
            if let responseObject = try? JSONDecoder().decode(ExpectedResult.self, from: data) {
                return responseObject
            }
            return nil
        } else {
            debugPrint("no file")
        }
    } catch {
        debugPrint(error.localizedDescription)
    }
    return nil
}
