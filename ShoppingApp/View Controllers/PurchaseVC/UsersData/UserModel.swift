//
//  File.swift
//  ShoppingApp
//
//  Created by Rinchu on 27/03/23.
//

import Foundation

struct Users : Codable{
    var id : Int
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
    var address: UserAddress
    var companyDetails: CompanyDetails
    
    enum CodingKeys: String,CodingKey{
        case id = "id"
        case name = "name"
        case username = "username"
        case email = "email"
        case phone = "phone"
        case website = "website"
        case companyDetails = "company"
        case address = "address"
        
    }
}

struct UserAddress: Codable {
    var street : String
    var suite: String
    var city: String
    var zipcode: String
    var geoLocation: GeoLocation
    
    enum CodingKeys: String,CodingKey {
        case street = "street"
        case suite = "suite"
        case city = "city"
        case zipcode = "zipcode"
        case geoLocation = "geo"
    }
}

struct GeoLocation: Codable {
    var lattitude: String
    var longitude: String
    
    enum CodingKeys: String,CodingKey {
        case lattitude = "lat"
        case longitude = "lng"
    }
}


struct CompanyDetails: Codable {
    var companyName: String
    var catchPhrase: String
    var bs: String
    
    enum CodingKeys: String,CodingKey {
        case companyName = "name"
        case catchPhrase = "catchPhrase"
        case bs = "bs"
    }
}
