//
//  RecipieDetail.swift
//  ELTest
//
//  Created by Omar Gonzalez on 31/10/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recipieDetail = try? newJSONDecoder().decode(RecipieDetail.self, from: jsonData)

import Foundation

// MARK: - RecipieDetail
struct RecipieDetail: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let servings, readyInMinutes: Int?
    let aggregateLikes, healthScore: Int?
    let pricePerServing: Double?
    let glutenFree: Bool?
    let extendedIngredients: [ExtendedIngredient]?
    let summary: String?
}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Codable {
    let aisle: String?
    let amount: Double?
    let consitency: Consitency?
    let id: Int?
    let image: String?
    let measures: Measures?
    let meta: [String]?
    let name, original, originalName, unit: String?
}

enum Consitency: String, Codable {
    case liquid = "liquid"
    case solid = "solid"
}

// MARK: - Measures
struct Measures: Codable {
    let metric, us: Metric?
}

// MARK: - Metric
struct Metric: Codable {
    let amount: Double?
    let unitLong, unitShort: String?
}

// MARK: - WinePairing
struct WinePairing: Codable {
    let pairedWines: [String]?
    let pairingText: String?
    let productMatches: [ProductMatch]?
}

// MARK: - ProductMatch
struct ProductMatch: Codable {
    let id: Int?
    let title, productMatchDescription, price: String?
    let imageURL: String?
    let averageRating: Double?
    let ratingCount: Int?
    let score: Double?
    let link: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case productMatchDescription = "description"
        case price
        case imageURL = "imageUrl"
        case averageRating, ratingCount, score, link
    }
}
