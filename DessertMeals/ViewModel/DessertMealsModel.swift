//
//  SearchMealsViewModel.swift
//  DessertMeals
//
//  Created by Michael Wilkowski on 2/6/24.
//

import SwiftUI
import MealDB

class DessertMealsModel: ObservableObject {
    @Published var meals: [MealKey] = []
    @Published var favorites: [Meal] = []
    
    private let api = MealAPI()
    private let cache = MealCache()
    
    init(){
//        fetchFavorites()
    }
    
    @MainActor
    func fetchMeals(category: String = "Dessert") async {
        do {
            let meals = try await api.filterMeals(category: category)
            self.meals = meals.sorted{$0.name < $1.name}
            print(self.meals.count)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    @MainActor
    func fetch(meal: MealKey) async -> Meal? {
        do {
            if let cachedMeal = cache.meal(by: meal.id) {
                print("Using cached meal: \(meal.name)")
                return cachedMeal
            } else {
                print("Fetching meal: \(meal.name)")
                let meal = try await api.fetchMeal(id: meal.id)
                cache.set(meal: meal)
                return meal
            }

        } catch {
            return nil
        }
    }
    
    func fetchFavorites() {
        guard let data = UserDefaults.standard.data(forKey: "favorites"),
              let favoriteMeals = try? JSONDecoder().decode([Meal].self, from: data) else {return}
        self.favorites = favoriteMeals
    }
    
    func remove(meal: Meal) {
        self.favorites.removeAll(where: {$0.id == meal.id})
        saveFavorites()
    }
    
    func removeMeal(at index: IndexSet) {
        self.favorites.remove(atOffsets: index)
        saveFavorites()
    }
    
    func add(meal: Meal) {
        self.favorites.append(meal)
        saveFavorites()
    }
    
    private func saveFavorites() {
        if let favoriteData = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.setValue(favoriteData, forKey: "favorites")
        }
    }
}

