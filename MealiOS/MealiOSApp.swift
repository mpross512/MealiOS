//
//  MealiOSApp.swift
//  MealiOS
//
//  Created by Michael Ross on 10/4/24.
//

import SwiftUI
import SwiftData

@main
struct MealiOSApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @State private var mealieClient = MealieClient()

    var body: some Scene {
        WindowGroup {
            MasterView()
                .environment(mealieClient)
        }
        .modelContainer(sharedModelContainer)
    }
}
