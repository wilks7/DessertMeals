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
        tags = try container.decode(String.self, forKey: .tags)
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
