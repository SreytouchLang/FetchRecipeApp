//
//  APIService.swift
//  FetchRecipeApp
//
//  Created by Sreytouch(Jessica) on 1/29/25.
//

import Foundation

class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchRecipes(from url: URL) async throws -> [Recipe] {
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(RecipeResponse.self, from: data)
        return response.recipes
    }
}

