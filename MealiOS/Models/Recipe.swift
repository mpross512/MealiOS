//
//  Recipe.swift
//  MealiOS
//
//  Created by Michael Ross on 10/5/24.
//

import Foundation

// MARK: - RecipePage
struct RecipePage: Codable {
    let page, perPage, total, totalPages: Int
    let items: [Recipe]

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case items
    }
}

// MARK: - Item
struct Recipe: Codable, Identifiable {
    let id, userID, groupID: UUID
    let name: String?
    let recipeYield: String?
    let totalTime, prepTime, cookTime, performTime: String?
    let description: String
    let rating: Int?
    let orgURL: String?
    let dateAdded, dateUpdated, createdAt, updateAt: String
    let lastMade: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case groupID = "groupId"
        case name, recipeYield, totalTime, prepTime, cookTime, performTime, description, rating, orgURL, dateAdded, dateUpdated, createdAt, updateAt, lastMade
    }
}
