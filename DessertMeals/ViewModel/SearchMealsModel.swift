//
//  SearchMealsViewModel.swift
//  DessertMeals
//
//  Created by Michael Wilkowski on 2/6/24.
//

import SwiftUI
import MealDB

@Observable
class SearchMealsModel {
    var meals: [MealKey] = []    
    var selectedCategory = "Dessert"
    var searchText = ""
    var categories = [MealCategory]()
    
    private let api = MealAPI()

    
    @MainActor
    func fetchCategories() async {
        guard categories.isEmpty else {return}
        do {
            let categories = try await api.fetchMealCategories()
            self.categories = categories
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchMeals(category: String = "Dessert") async {
        do {
            let meals = try await api.filterMeals(category: category)
            self.meals = meals.sorted{$0.name < $1.name}
        } catch {
            print(error.localizedDescription)
        }
    }
    

    
    func fetch(meal: MealKey) async -> Meal? {
        do {
            let meal = try await api.fetchMeal(id: meal.id)
            return meal
        } catch {
            print(error)
            return nil
        }
    }
    
}
