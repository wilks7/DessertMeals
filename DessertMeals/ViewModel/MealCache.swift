//
//  MealCache.swift
//  DessertMeals
//
//  Created by Michael Wilkowski on 2/12/24.
//

import Foundation
import MealDB

class MealCache {
    private var meals: [String: Meal] = [:]
    private var accessOrder: [String] = []
    private let capacity: Int

    init(capacity: Int = 10) {
        self.capacity = max(capacity, 1)
    }

    func meal(by id: String) -> Meal? {
        if let meal = meals[id] {
            if let index = accessOrder.firstIndex(of: id) {
                accessOrder.remove(at: index)
            }
            accessOrder.append(id)
            return meal
        }
        return nil
    }

    func set(meal: Meal) {
        if accessOrder.count >= capacity, let idToRemove = accessOrder.first {
            meals.removeValue(forKey: idToRemove)
            accessOrder.removeFirst()
        }

        meals[meal.id] = meal
        accessOrder.append(meal.id)
    }
}
