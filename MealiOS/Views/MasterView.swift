//
//  MasterView.swift
//  MealiOS
//
//  Created by Michael Ross on 10/4/24.
//

import SwiftUI

struct MasterView: View {
    
    @State private var loggedIn = false
    
    var body: some View {
        ZStack {
            if(loggedIn) {
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
