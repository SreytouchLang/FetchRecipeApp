//
//  RecipeDetailView.swift
//  FetchRecipeApp
//
//  Created by Sreytouch(Jessica) on 1/29/25.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let largePhotoURL = recipe.photoURLLarge {
                    AsyncImage(url: largePhotoURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(radius: 4)
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }

                }

                Text(recipe.name)
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 16)

                Text("Cuisine: \(recipe.cuisine)")
                    .font(.title3)
                    .foregroundColor(.secondary)

                // Only show the Source URL if it exists
                if let sourceURL = recipe.sourceURL {
                    Link("View Recipe Source", destination: sourceURL)
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.top, 8)
                }

                // Only show the YouTube link if it exists
                if let youtubeURL = recipe.youtubeURL {
                    Link("Watch on YouTube", destination: youtubeURL)
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding(.top, 8)
                }
            }
            .padding()
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}



#Preview {
    RecipeDetailView(recipe: Recipe(
        id: "number",
        name: "Example Recipe",
        cuisine: "Italian", 
        photoURLSmall: URL(string: "https://example.com/photo.jpg"),
        photoURLLarge: URL(string: "https://example.com/photo.jpg"),
        sourceURL: URL(string: "https://example.com"),
        youtubeURL: URL(string: "https://youtube.com")))
}
