//
//  RecipeDetailViewTests.swift
//  FetchRecipeAppTests
//
//  Created by Sreytouch(Jessica) on 1/29/25.
//

// RecipeDetailViewTests.swift
import XCTest
import SwiftUI
@testable import FetchRecipeApp

class RecipeDetailViewTests: XCTestCase {

    func testRecipeDetailView() {
        // Prepare the test data
        let recipe = Recipe(id: "1", name: "Spaghetti", cuisine: "Italian", photoURLSmall: nil, photoURLLarge: nil, sourceURL: nil, youtubeURL: nil)

        // Initialize the view
        let view = RecipeDetailView(recipe: recipe)

        // Use a hosting controller to test the view
        let hostingController = UIHostingController(rootView: view)
        
        // Wait for the view to load
        let viewLoaded = hostingController.view

        // Make sure the view is loaded and accessible
        XCTAssertNotNil(viewLoaded, "The view should be loaded.")
    }
}


