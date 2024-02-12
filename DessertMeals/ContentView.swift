//
//  ContentView.swift
//  DessertMeals
//
//  Created by Michael Wilkowski on 2/6/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(Navigation.self) private var navigation
    
    @State private var selected: TabItem = .search
    
    var body: some View {
        @Bindable var navigation = navigation
            TabView(selection: $selected) {
                SearchMealsView()
                    .tabItem { Label(TabItem.search.label, systemImage: TabItem.search.systemImage) }
                    .tag(TabItem.search)
                FavoriteMealsList()
                    .tabItem { Label(TabItem.favorites.label, systemImage: TabItem.favorites.systemImage) }
                    .tag(TabItem.favorites)

            }

    }
}
enum TabItem: String, Identifiable, Hashable, CaseIterable {
    
    var id: String { rawValue }
    case search, categories, favorites
    
    var label: String { rawValue.capitalized }
    
    var systemImage: String {
        switch self {
        case .search:
            "magnifyingglass"
        case .categories:
            "list.bullet"
        case .favorites:
            "star"
        }
        
    }
}

#Preview {
    ContentView()
}
