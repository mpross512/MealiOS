//
//  LoginView.swift
//  MealiOS
//
//  Created by Michael Ross on 10/4/24.
//

import SwiftUI

struct LoginView: View {
    @State private var mealieURL: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    
    private var mealieClient = MealieClient()
    
    var body: some View {
        VStack {
            Text("MealiOS")
                .font(.largeTitle)
            Text("An Unnoficial iOS Mealie Client")
            TextField("Mealie URL", text: $mealieURL)
                .textContentType(.URL)
                .keyboardType(.URL)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            SecureField("Password", text: $password)
                .textContentType(.password)
            Button("Login") {
                Task {
                    await mealieClient.getToken(url: mealieURL, username: username, password: password)
                }
            }
        }
        .padding(40)
    }
}

#Preview {
    LoginView()
}
