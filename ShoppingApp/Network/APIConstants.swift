//
//  APIConstants.swift
//  OverTimy
//
//  Created by Rather on 21/03/213.
//

import Foundation
import Alamofire

//MARK: - Define All apis here
enum API {
    case Login(email:String, password:String)
    case SignUp(username:String, email:String, password:String)
    case Posts
    case Users
    case UserPosts(id: String)
    case UserAlbums(id: String)
    case Albums
    case TODO
    case UserPostComments(postId:String)
    case AlbumPhotos(id:String)
    
    
}

protocol Router {
    var route: String { get }
    var parameters: [String : Any] { get }
}

extension API: Router {
    var encoding: ParameterEncoding {
        switch self {
//        case .verifyOtp(_):
//           return JSONEncoding.default
            
//        case .updatePaymentStatus(_):
//            return JSONEncoding.prettyPrinted
            
        default:
           return URLEncoding.default
        }
    }
    
    var route: String {
        switch self {
        case .Posts:
            return "posts"
        case .Users:
            return "users"
        case .UserPosts(let id):
            return "users/\(id)/posts"
        case .UserAlbums(let id):
            return "users/\(id)/albums"
        case .Albums:
            return "albums"
        case .TODO:
            return "todos"
        case .UserPostComments(let id):
            return "posts/\(id)/comments"
            
        case .AlbumPhotos(let id):
            return "albums/\(id)/photos"
        case .Login(_, _):
            return ""
        case .SignUp(_, _, _):
            return ""
        }
    }
    
    var headers: HTTPHeaders {
        switch self{
             case .Posts:
            let token = APIHandler.getTokenUDID()
             return ["Content-Type": "application/json","Authorization":"Bearer \(token)"]
        default:
            return  ["Content-Type": "application/json"]
        }
    }
    
    var parameters: [String:Any] {
        switch self {
        case .SignUp(let username, let email,let password):
            return ["username":username,"email":email,"password":password]
        default:
            return [:]
        }
    }
    
    var baseUrl: String {
        switch self {
        
        default:
            return "https://jsonplaceholder.typicode.com/"
        }
    }
   
    var method: Alamofire.HTTPMethod {
        switch self {
//        case .verifyOtp(_),.getMatchedVendors(_),.serviceOrder(_),.order(_),.addVendorReview(_),.feedback(_):
//            return .post
          //  return .get
       
          //  return .put
//        case .userProfileUpdate(_),.updatePaymentStatus(_):
//        return .put
        default:
            return .get
        }
    }
}
