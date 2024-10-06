//
//  RecipesView.swift
//  MealiOS
//
//  Created by Michael Ross on 10/4/24.
//

import SwiftUI

struct RecipesView: View {
    @Environment(MealieClient.self) var mealieClient
    @State var recipes = [Recipe]()
    
    var body: some View {
        NavigationSplitView {
            List(recipes) { recipe in
                NavigationLink {
                    RecipeDetailView(recipe: recipe)
                } label: {
                    HStack {
                        AsyncImage(url: URL(string: "https://\(mealieClient.serverURL!)/api/media/recipes/\(recipe.id.uuidString.lowercased())/images/original.webp")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }.frame(width: 100, height: 100)
                        VStack(alignment: .leading) {
                            Text(recipe.name!)
                                .font(.headline)
                            Text(recipe.totalTime ?? "")
                                .font(.caption)
                        }
                    }
                }
            }.navigationTitle("Recipes")
        } detail: {
            Text("Select a recipe")
        }.task {
            recipes = await mealieClient.getRecipes()
        }
    }
}

#Preview {
    var mealieClient = MealieClient()
    //mealieClient.login(url: "mealie.rossjr.dev", username: "mross", password: "Mike1200")
    RecipesView()
        .environment(mealieClient)
}
