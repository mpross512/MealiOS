//
//  HomeView.swift
//  MealiOS
//
//  Created by Michael Ross on 10/4/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            Tab("Recipes", systemImage: "list.bullet") {
                RecipesView()
            }
            
            Tab("Meal Planner", systemImage: "list.bullet") {
                MealPlannerView()
            }
            
            Tab("Shopping List", systemImage: "list.bullet") {
                ShoppingListView()
            }
            
            Tab("Cookbooks", systemImage: "list.bullet") {
                CookbookView()
            }
            
            Tab("Settings", systemImage: "list.bullet") {
                SettingsView()
            }
        }
    }
}

#Preview {
    HomeView()
}
