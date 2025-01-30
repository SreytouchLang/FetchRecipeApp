//
//  RecipeListView.swift
//  FetchRecipeApp
//
//  Created by Sreytouch (Jessica) on 1/29/25.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeListViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Loading recipes...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .padding()
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else if viewModel.recipes.isEmpty {
                        Text("No recipes available.")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.recipes) { recipe in
                                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                    RecipeCard(recipe: recipe)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 10)
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(.systemGroupedBackground))
            .onAppear {
                Task {
                    await viewModel.loadRecipes()
                }
            }
            .refreshable {
                await viewModel.loadRecipes()
            }
        }
    }
}

#Preview {
    RecipeListView()
}
