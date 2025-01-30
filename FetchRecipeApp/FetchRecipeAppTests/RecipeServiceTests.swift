//
//  RecipeServiceTests.swift
//  FetchRecipeAppTests
//
//  Created by Sreytouch(Jessica) on 1/29/25.
//

import XCTest
import Foundation
@testable import FetchRecipeApp

// MARK: - RecipeService Mock Implementation
class MockRecipeServic: RecipeServiceProtocol {
    enum Result {
        case success([Recipe])
        case failure(Error)
    }
    
    var result: Result
    
    init(result: Result) {
        self.result = result
    }
    
    func fetchRecipes() async throws -> [Recipe] {
        switch result {
        case .success(let recipes):
            return recipes
        case .failure(let error):
            throw error
        }
    }
}


// MARK: - RecipeService Unit Tests
final class RecipeServiceTests: XCTestCase {
    
    // MARK: - Test Success Scenario
    @MainActor func testFetchRecipesSuccess() async {
        // Prepare mock data for successful fetch
        let expectedRecipes = [
            Recipe(id: "1", name: "Spaghetti", cuisine: "Italian", photoURLSmall: nil, photoURLLarge: nil, sourceURL: nil, youtubeURL: nil),
            Recipe(id: "2", name: "Tacos", cuisine: "Mexican", photoURLSmall: nil, photoURLLarge: nil, sourceURL: nil, youtubeURL: nil)
        ]
        
        let mockService = MockRecipeServic(result: .success(expectedRecipes))
        
        do {
            let recipes = try await mockService.fetchRecipes()
            XCTAssertEqual(recipes.count, expectedRecipes.count, "The number of recipes should match.")
            XCTAssertEqual(recipes[0].name, expectedRecipes[0].name, "The first recipe name should match.")
        } catch {
            XCTFail("Fetching recipes failed with error: \(error)")
        }
    }
    
    // MARK: - Test Failure Scenario (Malformed JSON)
    @MainActor func testFetchRecipesFailureMalformedJSON() async {
        let mockError = NSError(domain: "com.fetchrecipeapp", code: 999, userInfo: [NSLocalizedDescriptionKey: "Malformed JSON"])
        let mockService = MockRecipeServic(result: .failure(mockError))
        
        do {
            _ = try await mockService.fetchRecipes()
            XCTFail("Fetching recipes should have failed due to malformed JSON.")
        } catch {
            XCTAssertEqual((error as NSError).code, mockError.code, "The error code should match the expected error.")
        }
    }
    
    // MARK: - Test Empty Response Scenario
    @MainActor func testFetchRecipesEmptyResponse() async {
        // Simulate an empty response
        let emptyRecipes: [Recipe] = []
        let mockService = MockRecipeServic(result: .success(emptyRecipes))
        
        do {
            let recipes = try await mockService.fetchRecipes()
            XCTAssertTrue(recipes.isEmpty, "The recipes list should be empty.")
        } catch {
            XCTFail("Fetching recipes failed with error: \(error)")
        }
    }
}
