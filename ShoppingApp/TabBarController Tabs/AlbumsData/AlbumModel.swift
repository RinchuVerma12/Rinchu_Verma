//
//  AlbumModel.swift
//  ShoppingApp
//
//  Created by Rinchu on 27/03/23.
//

import Foundation

struct Albums: Codable{
    var userId: Int
    var id: Int
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title = "title"
    }
}

