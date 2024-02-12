//
//  File.swift
//  
//
//  Created by Michael Wilkowski on 2/6/24.
//

import Foundation

public struct MealCategory: Identifiable, Decodable {
    public let id: String
    public let name: String?
    public let thumbnail: URL?
    public let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case thumbnail = "strThumb"
        case description = "strCategoryDescription"
    }
}
