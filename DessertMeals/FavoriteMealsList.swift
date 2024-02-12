//
//  FavoriteMealsList.swift
//  DessertMeals
//
//  Created by Michael Wilkowski on 2/6/24.
//

import SwiftUI
import MealDB

struct FavoriteMealsList: View {
    @EnvironmentObject private var model: DessertMealsModel
    
    var body: some View {
        NavigationView {
            Group {
                if !model.favorites.isEmpty {
                    List {
                        ForEach(model.favorites) { meal in
                            NavigationLink {
                                MealDetailView(meal: meal)
                            } label: {
                                MealCell(meal: meal)
                            }
                        }
                        .onDelete(perform: model.removeMeal)
                    }
                } else {
                    VStack {
                        Text("Search for meals to add them to your favorites")
                        Image(systemName: "fork.knife.circle")
                    }
                    .font(.largeTitle)
                }
            }
            .navigationTitle("Favorites")
        }
    }

}

#Preview {
    FavoriteMealsList()
}
