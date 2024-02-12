import XCTest
@testable import MealDB


extension MealDBTests {
    
    func testFetchCategories() async {
        do {
            let categories = try await api.fetchMealCategories()
            XCTAssertNotNil(categories, "Fetched categories should not be nil")
            XCTAssertGreaterThan(categories.count, 0, "Category list should not be empty")
        } catch {
            XCTFail("Listing categories failed with error: \(error.localizedDescription)")
        }
    }
    func testListCategories() async {
        do {
            let categories = try await api.listCategories()
            XCTAssertNotNil(categories, "Fetched categories should not be nil")
            XCTAssertGreaterThan(categories.count, 0, "Category list should not be empty")
        } catch {
            XCTFail("Listing categories failed with error: \(error.localizedDescription)")
        }
    }
    
    func testListAreas() async {
        do {
            let areas = try await api.listAreas()
            XCTAssertNotNil(areas, "Fetched areas should not be nil")
            XCTAssertGreaterThan(areas.count, 0, "Area list should not be empty")
        } catch {
            XCTFail("Listing areas failed with error: \(error.localizedDescription)")
        }
    }
    
    func testListIngredients() async {
        do {
            let ingredients = try await api.listIngredients()
            XCTAssertNotNil(ingredients, "Fetched ingredients should not be nil")
            XCTAssertGreaterThan(ingredients.count, 0, "Ingredients list should not be empty")
        } catch {
            XCTFail("Listing categories failed with error: \(error.localizedDescription)")
        }
    }
}
