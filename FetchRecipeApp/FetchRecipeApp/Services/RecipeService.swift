//
//  RecipeService.swift
//  FetchRecipeApp
//
//  Created by Sreytouch(Jessica) on 1/29/25.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes() async throws -> [Recipe]
}

class RecipeService: RecipeServiceProtocol {
    private let urls = [
        URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!,
//        URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!,
//        URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
    ]

    
    func fetchRecipes() async throws -> [Recipe] {
        // Randomly pick one URL from the list
        let selectedURL = urls.randomElement()!
        
        let (data, response) = try await URLSession.shared.data(from: selectedURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        do {
            let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return decodedResponse.recipes
        } catch {
            throw error
        }
    }
}



