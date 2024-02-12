//
//  ContentView.swift
//  DessertMeals
//
//  Created by Michael Wilkowski on 2/6/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model = DessertMealsModel()

    @State private var selected: TabItem = .dessert
    
    var body: some View {
        TabView(selection: $selected) {
            DessertMealsView()
                .tabItem { TabItem.dessert.label }
                .tag(TabItem.dessert)
            FavoriteMealsList()
                .tabItem { TabItem.favorites.label }
                .tag(TabItem.favorites)

        }
        .environmentObject(model)
        .task {
            model.fetchFavorites()
            await model.fetchMeals()
        }
    }
}

enum TabItem: String, Identifiable, Hashable, CaseIterable {
    
    var id: String { rawValue }
    case dessert, favorites
    
    var title: String { rawValue.capitalized }
    
    var label: Label<Text,Image> {
        Label(title, systemImage: systemImage)
    }
    
    var systemImage: String {
        switch self {
        case .dessert:
            "birthday.cake"
        case .favorites:
            "star"
        }
    }
}

#Preview {
    ContentView()
}
