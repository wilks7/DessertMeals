import XCTest
@testable import MealDB

extension MealDBTests {

    func testFetchMealsByCategory() async {
        let category = "Seafood" // Known valid category for testing
        do {
            let meals = try await api.filterMeals(category: category)
            XCTAssertNotNil(meals, "Fetched meals should not be nil")
            XCTAssertGreaterThan(meals.count, 0, "Fetched meals for category '\(category)' should contain at least one meal")
        } catch {
            XCTFail("Fetching meals by category failed with error: \(error.localizedDescription)")
        }
    }
    
    func testFetchMealsByArea() async {
        let area = "Canadian" // Known valid area for testing
        do {
            let meals = try await api.filterMeals(area: area)
            XCTAssertNotNil(meals, "Fetched meals should not be nil")
            XCTAssertGreaterThan(meals.count, 0, "Fetched meals for area '\(area)' should contain at least one meal")
        } catch {
            XCTFail("Fetching meals by category failed with error: \(error.localizedDescription)")
        }
    }
    
    func testFetchMealsByIngredients() async {
        let ingredient = "Salt"// Known valid ingredient for testing
        do {
            let meals = try await api.filterMeals(ingredient: ingredient)
            XCTAssertNotNil(meals, "Fetched meals should not be nil")
            XCTAssertGreaterThan(meals.count, 0, "Fetched meals for ingredient '\(ingredient)' should contain at least one meal")
        } catch {
            XCTFail("Fetching meals by category failed with error: \(error.localizedDescription)")
        }
    }


}
