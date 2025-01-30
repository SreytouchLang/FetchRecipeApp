//
//  RecipeListViewModel.swift
//  FetchRecipeApp
//
//  Created by Sreytouch(Jessica) on 1/29/25.
//

import Foundation

@MainActor
class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let recipeService: RecipeServiceProtocol

    init(recipeService: RecipeServiceProtocol = RecipeService()) {
        self.recipeService = recipeService
    }

    func loadRecipes() async {
        isLoading = true
        errorMessage = nil

        do {
            let fetchedRecipes = try await recipeService.fetchRecipes()
            if fetchedRecipes.isEmpty {
                // No recipes, we won't set an error message here
                recipes = []
            } else {
                recipes = fetchedRecipes
            }
        } catch {
            // Handle errors here
            errorMessage = "Failed to load recipes. Please try again."
        }

        isLoading = false
    }
}



