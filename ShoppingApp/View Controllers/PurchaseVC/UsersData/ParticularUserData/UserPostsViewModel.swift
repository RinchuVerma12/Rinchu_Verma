//
//  UserDataViewModel.swift
//  ShoppingApp
//
//  Created by Rinchu on 28/03/23.
//

import Foundation

class UserPostsViewModel {
    
    var userPosts = [Posts]()
    var Id = ""
    func getPostsOfAUser(completion: @escaping (Bool, Error?) -> ()) {
        APIHandler.opertationWithRequest(withApi: .UserPosts(id: Id)) { (result: Result<[Posts], Error>) in
            switch result {
            case .success(let object):
                self.userPosts = object
                completion(true, nil)
                
            case .failure(let error):
                Utility.printToConsole(message: error)
                completion(false, error)
            }
        }
    }
}
