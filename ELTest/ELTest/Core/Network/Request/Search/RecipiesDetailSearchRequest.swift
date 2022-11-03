//
//  RecipiesDetailSearchRequest.swift
//  ELTest
//
//  Created by Omar Gonzalez on 31/10/22.
//

import Foundation

final class RecipieDetailSearchRequest: RequestProtocol {
    var recipieId: String

    init(recipieId: String = "") {
        self.recipieId = recipieId
    }

    var path: String {
        return "/recipes/\(recipieId)/information"
    }

    var parameters: [String : String] {
        return [
            "apiKey": Constants.apiKey,
        ]
    }
}
