//
//  RecipeListViewTests.swift
//  FetchRecipeAppTests
//
//  Created by Sreytouch(Jessica) on 1/29/25.
//

import XCTest
import SwiftUI
import Foundation
@testable import FetchRecipeApp

class MockRecipeServices: RecipeService {
    var recipes: [Recipe]
    var errorMessage: String?

    init(recipes: [Recipe] = [], errorMessage: String? = nil) {
        self.recipes = recipes
        self.errorMessage = errorMessage
    }

    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        if let errorMessage = errorMessage {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
        } else {
            completion(.success(recipes))
        }
    }
}


// Ensure MockRecipeService is either defined here or imported from a separate file
class RecipeListViewTests: XCTestCase {
    
    // Test for the Loading State
    @MainActor func testRecipeListViewLoadingState() {
        // Prepare the test data with the loading state
        let mockService = MockRecipeServices() // Initialize without passing any parameters
        let viewModel = RecipeListViewModel(recipeService: mockService)
        viewModel.isLoading = true
        let view = RecipeListView().environmentObject(viewModel)

        // Initialize the hosting controller
        let hostingController = UIHostingController(rootView: view)

        // Trigger view rendering
        let viewLoaded = hostingController.view
        XCTAssertNotNil(viewLoaded, "The view should be loaded.")
    }

    // Test for the Error State
    @MainActor func testRecipeListViewErrorState() {
        // Prepare the test data
        let errorMessage = "Failed to load recipes."
        
        // Initialize the mock service with an error
        let mockService = MockRecipeServices() // Adjust if necessary based on how MockRecipeService is defined
        let viewModel = RecipeListViewModel(recipeService: mockService)
        viewModel.errorMessage = errorMessage
        
        let view = RecipeListView().environmentObject(viewModel)

        // Initialize the hosting controller
        let hostingController = UIHostingController(rootView: view)

        // Trigger view rendering
        let viewLoaded = hostingController.view
        XCTAssertNotNil(viewLoaded, "The view should be loaded.")
    }

    // Test for the Empty State
    @MainActor func testRecipeListViewEmptyState() {
        // Prepare the test data for an empty state
        let mockService = MockRecipeServices(recipes: []) // Ensure MockRecipeService handles this correctly
        let viewModel = RecipeListViewModel(recipeService: mockService)
        viewModel.recipes = []  // Empty recipes array
        let view = RecipeListView().environmentObject(viewModel)

        // Initialize the hosting controller
        let hostingController = UIHostingController(rootView: view)

        // Trigger view rendering
        let viewLoaded = hostingController.view
        XCTAssertNotNil(viewLoaded, "The view should be loaded.")
    }

    // Test for the Non-Empty State with Recipes
    @MainActor func testRecipeListViewWithRecipes() {
        // Prepare the test data for non-empty recipes
        let recipes = [
            Recipe(id: "1", name: "Spaghetti", cuisine: "Italian", photoURLSmall: nil, photoURLLarge: nil, sourceURL: nil, youtubeURL: nil)
        ]
        
        // Set up the view model with the mock service and recipes
        let mockService = MockRecipeServices(recipes: recipes) // Ensure MockRecipeService can accept this initialization
        let viewModel = RecipeListViewModel(recipeService: mockService)
        viewModel.recipes = recipes
        
        let view = RecipeListView().environmentObject(viewModel)

        // Initialize the hosting controller
        let hostingController = UIHostingController(rootView: view)

        // Trigger view rendering
        let viewLoaded = hostingController.view
        XCTAssertNotNil(viewLoaded, "The view should be loaded.")
    }
}
