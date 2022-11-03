//
//  RecipiesRequest.swift
//  ELTest
//
//  Created by Omar Gonzalez on 27/10/22.
//

import Foundation

final class RecipiesSearchRequest: RequestProtocol {

    var keyWord: String

    init(keyWord: String = "") {
        self.keyWord = keyWord
    }

    var path: String {
        return "/recipes/complexSearch"
    }

    var parameters: [String : String] {
        return [
            "query" : keyWord,
            "apiKey": Constants.apiKey
        ]
    }
}
