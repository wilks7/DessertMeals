//
//  SearchMealsView.swift
//  DessertMeals
//
//  Created by Michael Wilkowski on 2/6/24.
//

import SwiftUI
import MealDB

struct DessertMealsView: View {
    @EnvironmentObject private var model: DessertMealsModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(model.meals) { meal in
                    NavigationLink {
                        MealDetailView(mealKey: meal)
                            .environmentObject(model)
                    } label: {
                        MealCell(mealKey: meal)
                    }
                }
            }
            .navigationTitle("Desserts")
            .task {
                await model.fetchMeals()
            }
        }
    }
}


#Preview {
    DessertMealsView()
}
