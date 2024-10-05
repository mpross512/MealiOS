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
    
    init() {
        self.baseURL = ""
        self.apiBaseUrl = HttpUrl(host: baseURL, trailingSlashEnabled: false)
    }
    
    init(baseURL: String = "") {
        self.baseURL = baseURL
        self.apiBaseUrl = HttpUrl(host: baseURL, trailingSlashEnabled: false)
    }
    
    func login(username: String, password: String) async throws {
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
        let json = try JSONSerialization.jsonObject(with: response.data, options: [])
        print(json)
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
