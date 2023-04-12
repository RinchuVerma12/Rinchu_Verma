//
//  UserCommentsModal.swift
//  ShoppingApp
//
//  Created by Rinchu on 29/03/23.
//

import Foundation
struct UserComments: Codable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
    
    enum CodingKeys: String, CodingKey {
        case postId = "postId"
        case id = "id"
        case name = "name"
        case email = "email"
        case body = "body"
    }
}
