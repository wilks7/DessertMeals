//
//  FavoriteMealsList.swift
//  DessertMeals
//
//  Created by Michael Wilkowski on 2/6/24.
//

import SwiftUI
import MealDB

struct FavoriteMealsList: View {
    @AppStorage("favorites") var favoriteData: Data = Data()

    @State private var meals: [Meal] = []
    
    
    var body: some View {
        Group {
            if !meals.isEmpty {
                List {
                    ForEach(meals) { meal in
                        NavigationLink {
                            MealDetailView(meal: meal)
                        } label: {
                            MealCell(meal: meal)
                        }
                    }
                }
            } else {
                ContentUnavailableView("Search for meals to add them to your favorites",
                                       systemImage: "fork.knife.circle")
            }
        }
        .task {
            await fetchMeals()
        }
    }
    
    private func fetchMeals() async {
        guard let favoriteMeals = try? JSONDecoder().decode([String].self, from: favoriteData) else {return}
        let api = MealAPI()
        var meals = [Meal]()
        for mealID in favoriteMeals {
            let meal = try? await api.fetchMeal(id: mealID)
            if let meal {
                meals.append(meal)
            }
        }
        self.meals = meals
    }
}

#Preview {
    FavoriteMealsList()
}
