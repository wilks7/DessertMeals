//
//  File.swift
//  
//
//  Created by Michael Wilkowski on 2/6/24.
//

import Foundation

extension MealAPI {
    
    struct MealResponse: Decodable {
        let meals: [Meal]
    }
    
    struct QueryMealResponse: Decodable {
        let meals: [MealKey]
    }
    
    struct FetchCategoriesResponse: Decodable {
        let categories: [MealCategory]
    }
    
    struct ListCategoryResponse: Decodable {
        struct Category: Decodable {
            let strCategory: String
        }
        let meals: [Category]
    }
    
    struct ListIngredientsResponse: Decodable {
        struct Ingredient: Decodable {
            let strIngredient: String
        }
        let meals: [Ingredient]
    }
    
    struct ListAreaResponse: Decodable {
        struct Area: Decodable {
            let strArea: String
        }
        let meals: [Area]
    }
}
