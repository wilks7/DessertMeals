//
//  DessertMealsApp.swift
//  DessertMeals
//
//  Created by Michael Wilkowski on 2/6/24.
//

import SwiftUI
import SwiftData

@main
struct DessertMealsApp: App {
    @State private var navigation = Navigation()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(navigation)
        }
    }
}
