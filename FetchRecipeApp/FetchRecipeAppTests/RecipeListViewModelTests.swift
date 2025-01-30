//
//  RecipeListViewModelTests.swift
//  FetchRecipeAppTests
//
//  Created by Sreytouch(Jessica) on 1/29/25.
//

import XCTest
@testable import FetchRecipeApp

// MARK: - Mock Service for Testing
class MockRecipeService: RecipeServiceProtocol {
    var shouldReturnError = false
    var mockRecipes: [Recipe] = [
        Recipe(id: "1", name: "Spaghetti", cuisine: "Italian",
               photoURLSmall: nil, photoURLLarge: nil,
               sourceURL: nil, youtubeURL: nil),
        Recipe(id: "2", name: "Tacos", cuisine: "Mexican",
               photoURLSmall: nil, photoURLLarge: nil,
               sourceURL: nil, youtubeURL: nil)
    ]

    func fetchRecipes() async throws -> [Recipe] {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        } else {
            return mockRecipes
        }
    }
}

// MARK: - ViewModel Unit Tests
final class RecipeListViewModelTests: XCTestCase {
    var viewModel: RecipeListViewModel!
    var mockService: MockRecipeService!
    
    @MainActor override func setUp() {
        super.setUp()
        mockService = MockRecipeService()
        viewModel = RecipeListViewModel(recipeService: mockService)
    }
    
    @MainActor override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    // MARK: - Test Success Case
    func testLoadRecipes_Success() async {
        // Given
        mockService.shouldReturnError = false
        
        // When
        await viewModel.loadRecipes()
        
        // Then
        await MainActor.run {
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertEqual(viewModel.recipes.count, 2)
            XCTAssertEqual(viewModel.recipes.first?.name, "Spaghetti")
            XCTAssertNil(viewModel.errorMessage)
        }
    }
    
    // MARK: - Test Empty Response Case
    func testLoadRecipes_EmptyResponse() async {
        // Given
        mockService.mockRecipes = []
        
        // When
        await viewModel.loadRecipes()
        
        // Then
        await MainActor.run {
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertTrue(viewModel.recipes.isEmpty)
            XCTAssertNil(viewModel.errorMessage) // No error message for empty response
        }
    }
    
    // MARK: - Test Failure Case
    func testLoadRecipes_Failure() async {
        // Given
        mockService.shouldReturnError = true
        
        // When
        await viewModel.loadRecipes()
        
        // Then
        await MainActor.run {
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertTrue(viewModel.recipes.isEmpty)
            XCTAssertEqual(viewModel.errorMessage, "Failed to load recipes. Please try again.")
        }
    }
}
