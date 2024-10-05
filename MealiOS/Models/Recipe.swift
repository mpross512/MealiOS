//
//  Recipe.swift
//  MealiOS
//
//  Created by Michael Ross on 10/5/24.
//

import Foundation

public struct Recipe: Codable {
    let id: Int
    let name: String
    let description: String
    let image: String
    //let ingredients: [Ingredient]
    //let instructions: [Instruction]
}
