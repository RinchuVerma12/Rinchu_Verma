//
//  PostsModel.swift
//  ShoppingApp
//
//  Created by Ashu on 22/03/23.
//

import Foundation

struct Posts: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title = "title"
        case body = "body"
    }
}
