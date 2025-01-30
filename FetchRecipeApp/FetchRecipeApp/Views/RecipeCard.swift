//
//  RecipeCard.swift
//  FetchRecipeApp
//
//  Created by Sreytouch (Jessica) on 1/29/25.
//

import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: recipe.photoURLSmall) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: 170, height: 190) // Full GridItem Image
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 6) // Image Shadow
            } placeholder: {
                Color.gray.opacity(0.3)
                    .frame(width: 170, height: 190)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2) // Placeholder Shadow
            }

            // Gradient Overlay for Readability
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .lineLimit(1)

                    Text(recipe.cuisine)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 8),
                alignment: .bottomLeading
            )
        }
    }
}

#Preview {
    RecipeCard(recipe: Recipe(id: "1",
                              name: "Sample Recipe",
                              cuisine: "Italian",
                              photoURLSmall: URL(string: "https://via.placeholder.com/150")!,
                              photoURLLarge: URL(string: "https://via.placeholder.com/300")!,
                              sourceURL: URL(string: "https://www.example.com")!,
                              youtubeURL: URL(string: "https://www.youtube.com")!))
}
