//
//  SettingsView.swift
//  MealiOS
//
//  Created by Michael Ross on 10/5/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(MealieClient.self) var mealieClient
    
    var body: some View {
        List {
            Section(header: Text("Server Info")) {
                HStack {
                    Image(systemName: "server.rack")
                    Text(mealieClient.serverURL!)
                }
                HStack {
                    Image(systemName: "gearshape.2")
                    Text(mealieClient.version!)
                }
                Button {
                    mealieClient.logout()
                } label: {
                    HStack {
                        Image(systemName: "network.slash")
                        Text("Log Out")
                    }.foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
