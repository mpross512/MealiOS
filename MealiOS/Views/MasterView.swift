//
//  MasterView.swift
//  MealiOS
//
//  Created by Michael Ross on 10/4/24.
//

import SwiftUI

struct MasterView: View {
    @Environment(MealieClient.self) var mealieClient
    
    var body: some View {
        ZStack {
            if(mealieClient.loggedIn) {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    MasterView()
}
