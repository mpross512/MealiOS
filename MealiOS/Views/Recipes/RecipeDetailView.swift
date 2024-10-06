//
//  RecipeDetailView.swift
//  MealiOS
//
//  Created by Michael Ross on 10/5/24.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    var body: some View {
        VStack {
            Text(recipe.name!)
                .font(.title)
            
            Text(recipe.description)
        }
    }
}

#Preview {
    //RecipeDetailView()
}
