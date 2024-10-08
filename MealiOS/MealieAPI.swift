//
//  MealieAPI.swift
//  MealiOS
//
//  Created by Michael Ross on 10/5/24.
//

import Foundation
import SwiftHttp

struct MealieAPI : HttpCodablePipelineCollection {
    
    let client: HttpClient = UrlSessionHttpClient(logLevel: .info)
    
    private var baseURL = ""
    private var apiBaseUrl: HttpUrl
    private var apiToken: String?
    
    init() {
        self.baseURL = ""
        self.apiBaseUrl = HttpUrl(host: baseURL, trailingSlashEnabled: false)
    }
    
    init(baseURL: String = "") {
        self.baseURL = baseURL
        self.apiBaseUrl = HttpUrl(host: baseURL, trailingSlashEnabled: false)
    }
    
    init(baseURL: String, apiToken: String) {
        self.baseURL = baseURL
        self.apiBaseUrl = HttpUrl(host: baseURL, trailingSlashEnabled: false)
        self.apiToken = apiToken
    }
    
    func getToken() -> String? {
        apiToken
    }
    
    mutating func login(username: String, password: String) async throws -> Bool {
        let request = HttpRawRequest(
            url: apiBaseUrl.path(["api", "auth", "token"]),
            method: .post,
            headers: [
                "Content-Type" : "application/x-www-form-urlencoded",
                "Accept" : "application/json"
            ],
            body: [
                "username": username,
                "password": password,
                "remember_me": true
            ].percentEncoded()
        )
        
        let response = try await client.dataTask(request)
        if(response.statusCode == .ok) {
            let json = try JSONSerialization.jsonObject(with: response.data, options: []) as! [String:Any]
            let accessToken = json["access_token"] as? String
            apiToken = accessToken
            return true
        } else {
            return false
        }
    }
    
    func getVersion() async throws -> String {
        let request = HttpRawRequest(
            url: apiBaseUrl.path(["api", "app", "about"]),
            method: .get
        )
        let response = try await client.dataTask(request)
        let json = try JSONSerialization.jsonObject(with: response.data, options: []) as! [String:Any]
        return json["version"] as? String ?? ""
    }
    
    func getRecipes() async throws -> [Recipe] {        
        let recipePage: RecipePage = try await decodableRequest(executor: client.dataTask, url: apiBaseUrl.path(["api", "recipes"]), method: .get, headers: ["Authorization": "Bearer \(apiToken!)"])
        return recipePage.items
    }
    
}

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}
