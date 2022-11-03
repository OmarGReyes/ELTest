//
//  Recipie.swift
//  ELTest
//
//  Created by Omar Gonzalez on 27/10/22.
//

import Foundation

struct RecipieList: Decodable {
    let results: [Recipie]
}

struct Recipie: Decodable {
    let id: Int
    let title: String
    let imageURL: String
    
    init(id: Int, title: String, imageURL: String) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
    }
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image"
        case id, title
    }
}
