//
//  SearchMealsView.swift
//  DessertMeals
//
//  Created by Michael Wilkowski on 2/6/24.
//

import SwiftUI
import MealDB

struct SearchMealsView: View {
    @Environment(Navigation.self) private var navigation

    @State private var model = SearchMealsModel()
    @State private var showCategories = false
    
    var body: some View {
        @Bindable var navigation = navigation

        NavigationSplitView {
            List {
                ForEach(model.meals) { meal in
                    MealCell(mealKey: meal)
                    .onTapGesture{ tapped(meal: meal) }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Category") {
                        showCategories.toggle()
                    }
                }
            }
            .searchable(text: $model.searchText, prompt: Text("Search"))
            .task {
                await model.fetchMeals()
                await model.fetchCategories()
            }
            .sheet(isPresented: $showCategories) {
                List {
                    ForEach(model.categories) { category in
                        if let name = category.name {
                            VStack(alignment: .leading) {
                                Text(name)
                                    .font(.title3)
                                    .bold()
                                Text(category.description ?? "")
                                    .font(.caption)
                            }
                            .onTapGesture {
                                model.selectedCategory = name
                                showCategories = false
                            }
                        }

                    }
                }
            }
            .onChange(of: model.selectedCategory) { oldValue, newValue in
                if oldValue != newValue {
                    Task {
                        await model.fetchMeals(category:newValue)
                    }
                }
            }
            .navigationDestination(item: $navigation.selected) { meal in
                MealDetailView(meal: meal)
            }
        } detail: {
            Text("Select a meal")
        }
    }
    
    func tapped(meal key: MealKey) {
        Task {
            let meal = await model.fetch(meal: key)
            navigation.selected = meal
        }
    }
}

extension SearchMealsView {

}

#Preview {
    SearchMealsView()
}
