//
//  File 2.swift
//  
//
//  Created by Michael Wilkowski on 2/6/24.
//

import Foundation


extension MealAPI {
    
    public func fetchMeal(id: String) async throws -> Meal {
        let endpoint: String = "lookup.php?i=\(id)"
        let response: MealResponse = try await fetch(from: endpoint)
        guard let meal = response.meals.first else {
            throw URLError(.badServerResponse)
        }
        return meal
    }
    
    public func fetchRandomMeal() async throws -> Meal {
        let endpoint: String = "random.php"
        let response: MealResponse = try await fetch(from: endpoint)
        guard let meal = response.meals.first else {
            throw URLError(.badServerResponse)
        }
        return meal
    }
    
    public func searchMeal(name: String) async throws -> MealKey {
        let endpoint: String = "search.php?s=\(name)"
        let response: QueryMealResponse = try await fetch(from: endpoint)
        guard let meal = response.meals.first else {
            throw URLError(.badServerResponse)
        }
        return meal
    }
    
    public func searchMeal(letter: String) async throws -> MealKey {
        let endpoint: String = "search.php?f=\(letter)"
        let response: QueryMealResponse = try await fetch(from: endpoint)
        guard let meal = response.meals.first else {
            throw URLError(.badServerResponse)
        }
        return meal
    }
    
    public func filterMeals(category: String) async throws -> [MealKey] {
        let endpoint = "filter.php?c=\(category)"
        let response: QueryMealResponse = try await fetch(from: endpoint)
        return response.meals
    }
    
    public func filterMeals(area: String) async throws -> [MealKey] {
        let endpoint = "filter.php?a=\(area)"
        let response: QueryMealResponse = try await fetch(from: endpoint)
        return response.meals
    }
    
    public func filterMeals(ingredient: String) async throws -> [MealKey] {
        let endpoint = "filter.php?i=\(ingredient)"
        let response: QueryMealResponse = try await fetch(from: endpoint)
        return response.meals
    }
    
    public func fetchMealCategories() async throws -> [MealCategory] {
        let endpoint = "categories.php"
        let response: FetchCategoriesResponse = try await fetch(from: endpoint)
        return response.categories
    }
    
    public func listCategories() async throws -> [String] {
        let endpoint = "list.php?c=list"
        let response: ListCategoryResponse = try await fetch(from: endpoint)
        return response.meals.map{ $0.strCategory }

    }
    
    public func listAreas() async throws -> [String] {
        let endpoint = "list.php?a=list"
        let response: ListAreaResponse = try await fetch(from: endpoint)
        return response.meals.map{ $0.strArea }
    }
    
    public func listIngredients() async throws -> [String] {
        let endpoint = "list.php?i=list"
        let response: ListIngredientsResponse = try await fetch(from: endpoint)
        return response.meals.map{ $0.strIngredient }
    }

}
