//
//  File.swift
//  
//
//  Created by Michael Wilkowski on 2/6/24.
//

import Foundation

extension Meal: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case drinkAlternate = "strDrinkAlternate"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case thumbnail = "strMealThumb"
        case tags = "strTags"
        case youtubeURL = "strYoutube"
        case source = "strSource"
        case imageSource = "strImageSource"
        case creativeCommonsConfirmed = "strCreativeCommonsConfirmed"
        case dateModified = "dateModified"
    }
    
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?

        init?(stringValue: String) {
            self.stringValue = stringValue
            intValue = nil
        }

        init?(intValue: Int) {
            return nil
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        drinkAlternate = try container.decodeIfPresent(String.self, forKey: .drinkAlternate)
        category = try container.decode(String.self, forKey: .category)
        area = try container.decode(String.self, forKey: .area)
        instructions = try container.decode(String.self, forKey: .instructions)
        thumbnail = try container.decodeIfPresent(URL.self, forKey: .thumbnail)
        tags = try container.decodeIfPresent(String.self, forKey: .tags)
        youtubeURL = try container.decodeIfPresent(URL.self, forKey: .youtubeURL)
        source = try container.decodeIfPresent(URL.self, forKey: .source)
        imageSource = try container.decodeIfPresent(String.self, forKey: .imageSource)
        creativeCommonsConfirmed = try container.decodeIfPresent(String.self, forKey: .creativeCommonsConfirmed)
        dateModified = try container.decodeIfPresent(String.self, forKey: .dateModified)
        
        let values = try decoder.container(keyedBy: DynamicCodingKeys.self)

        var ingredients = [String]()
        var measures = [String]()

        for i in 1...20 {
            let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(i)")
            let measureKey = DynamicCodingKeys(stringValue: "strMeasure\(i)")

            if let ingredientKey,
                let ingredient = try values.decodeIfPresent(String.self, forKey: ingredientKey),
               !ingredient.isEmpty {
                ingredients.append(ingredient)
            }

            if let measureKey,
                let measure = try values.decodeIfPresent(String.self, forKey: measureKey),
               !measure.isEmpty {
                measures.append(measure)
            }
        }

        self.ingredients = ingredients
        self.measures = measures
    }
}

extension Meal: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Encoding basic properties
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(drinkAlternate, forKey: .drinkAlternate)
        try container.encode(category, forKey: .category)
        try container.encode(area, forKey: .area)
        try container.encode(instructions, forKey: .instructions)
        try container.encodeIfPresent(thumbnail, forKey: .thumbnail)
        try container.encodeIfPresent(tags, forKey: .tags)
        try container.encodeIfPresent(youtubeURL, forKey: .youtubeURL)
        try container.encodeIfPresent(source, forKey: .source)
        try container.encodeIfPresent(imageSource, forKey: .imageSource)
        try container.encodeIfPresent(creativeCommonsConfirmed, forKey: .creativeCommonsConfirmed)
        try container.encodeIfPresent(dateModified, forKey: .dateModified)
        
        // Encoding dynamic properties for ingredients and measures
        var dynamicContainer = encoder.container(keyedBy: DynamicCodingKeys.self)
        
        for i in 1...ingredients.count {
            let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(i)")!
            let measureKey = DynamicCodingKeys(stringValue: "strMeasure\(i)")!
            
            try dynamicContainer.encode(ingredients[i-1], forKey: ingredientKey)
            if i <= measures.count {
                try dynamicContainer.encode(measures[i-1], forKey: measureKey)
            }
        }
    }
}
