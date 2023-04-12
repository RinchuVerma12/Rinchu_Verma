//
//  TODOModel.swift
//  ShoppingApp
//
//  Created by Rinchu on 29/03/23.
//

import Foundation
struct TODO: Codable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title = "title"
        case completed = "completed"
    }
}
