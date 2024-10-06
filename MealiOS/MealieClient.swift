//
//  MealieClient.swift
//  MealiOS
//
//  Created by Michael Ross on 10/4/24.
//

import SwiftUI

@Observable class MealieClient {
    
    private var api = MealieAPI()
    var loggedIn = false
    public var serverURL: String?
    var version: String?
    
    init() {
        let defaults = UserDefaults.standard
        if let token = defaults.string(forKey: "token"), let url = defaults.string(forKey: "serverURL") {
            self.api = MealieAPI(baseURL: url, apiToken: token)
            self.serverURL = url
            loggedIn = true
            Task {
                self.version = try await api.getVersion()
            }
        }
    }
        
    public func login(url: String, username: String, password: String) async {
        self.api = MealieAPI(baseURL: url)
        
        do {
            self.loggedIn = try await api.login(username: username, password: password)
            if(loggedIn)
            {
                self.serverURL = url
                self.version = try await api.getVersion()
                print("Logged in with version \(version ?? "")")
                let defaults = UserDefaults.standard
                defaults.set(url, forKey: "serverURL")
                defaults.set(api.getToken()!, forKey: "token")
            }
        } catch {
            print(error)
        }
    }
    
    public func logout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "token")
        defaults.removeObject(forKey: "serverURL")
        self.loggedIn = false
    }
    
    public func getRecipes() async -> [Recipe] {
        do {
            return try await api.getRecipes()
        } catch {
            print(error)
            return []
        }
    }
}
