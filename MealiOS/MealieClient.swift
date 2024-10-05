//
//  MealieClient.swift
//  MealiOS
//
//  Created by Michael Ross on 10/4/24.
//

import Foundation

@Observable
public class MealieClient {
    
    private var api = MealieAPI()
        
    public func getToken(url: String, username: String, password: String) async {
        self.api = MealieAPI(baseURL: url)
        
        do {
            try await api.login(username: username, password: password)
        } catch {
            print(error)
        }
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
