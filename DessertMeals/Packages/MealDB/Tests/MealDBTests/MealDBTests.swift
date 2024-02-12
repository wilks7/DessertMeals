import XCTest
@testable import MealDB

final class MealDBTests: XCTestCase {
    let api = MealAPI()
    
    func testFetchMealByID() async {
        let id = "52893" // Known valid ID for testing
        do {
            let meal = try await api.fetchMeal(id: id)
            XCTAssertGreaterThan(meal.ingredients.count, 0, "Fetched meals should contain at least one ingredient")
            XCTAssertGreaterThan(meal.ingredients.count, 0, "Fetched meals should contain at least one measurement")
        } catch {
            XCTFail("Fetching meal failed with error: \(error.localizedDescription)")
        }
    }
    
    func testSearchMealByName() async {
        let name = "Arrabiata" // Known valid ID for testing
        do {
            let meal = try await api.searchMeal(name: name)
            XCTAssertGreaterThan(meal.name.count, 0, "Fetched meals should contain at least one ingredient")
        } catch {
            XCTFail("Fetching meal failed with error: \(error.localizedDescription)")
        }
    }
    
    func testSearchMealByLetter() async {
        let letter = "a" // Known valid ID for testing
        do {
            let meal = try await api.searchMeal(letter: letter)
            XCTAssertGreaterThan(meal.name.count, 0, "Fetched meals should contain at least one ingredient")
        } catch {
            XCTFail("Fetching meal failed with error: \(error.localizedDescription)")
        }
    }
    
    func testFetchMealWithInvalidID() async {
        let invalidID = "00000" // Known invalid for testing
        do {
            let _ = try await api.fetchMeal(id: invalidID)
            XCTFail("Fetching meal with invalid ID should have failed")
        } catch {
            // Test passes if fetching fails, optionally check error type or message if needed
            XCTAssert(true, "Expected failure when fetching meal with invalid ID")
        }
    }
}


