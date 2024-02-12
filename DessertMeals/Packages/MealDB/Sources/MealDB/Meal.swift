//
//  Meal.swift
//
//
//  Created by Michael Wilkowski on 2/6/24.
//

import Foundation

public struct Meal: Identifiable, Hashable {
    public let id: String
    public let name: String
    public let drinkAlternate: String?
    public let category: String
    public let area: String
    public let instructions: String
    public let thumbnail: URL?
    public let tags: String
    public let youtubeURL: URL?
    public let ingredients: [String]
    public let measures: [String]
    public let source: URL?
    public let imageSource: String?
    public let creativeCommonsConfirmed: String?
    public let dateModified: String?
}

public struct MealKey: Identifiable, Decodable {
    public let id: String
    public let name: String
    public let thumbnail: URL?
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case id = "idMeal"
        case thumbnail = "strMealThumb"
    }
}
