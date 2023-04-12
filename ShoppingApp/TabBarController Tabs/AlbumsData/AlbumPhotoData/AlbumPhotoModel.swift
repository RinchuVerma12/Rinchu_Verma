//
//  AlbumPhotoModel.swift
//  ShoppingApp
//
//  Created by Rinchu on 30/03/23.
//

import Foundation
struct AlbumPhoto: Codable{
    var albumId: Int
    var id: Int
    var title: String
    var url: String?
    var thumbnailUrl: URL
    enum CodingKeys:String,CodingKey{
        case albumId = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
    }
}
