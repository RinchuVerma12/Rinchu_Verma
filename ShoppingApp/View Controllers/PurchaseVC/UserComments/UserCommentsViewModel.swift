//
//  UserCommentsViewModel.swift
//  ShoppingApp
//
//  Created by Rinchu on 30/03/23.
//

import Foundation
class UserCommentsViewModel {
    
    var userCommentsData = [UserComments]()
    var id = ""
    func getUserComments(completion: @escaping (Bool, Error?) -> ()) {
        APIHandler.opertationWithRequest(withApi: .UserPostComments(postId: id)) { (result: Result<[UserComments], Error>) in
            switch result {
            case .success(let object):
                self.userCommentsData = object
                completion(true, nil)
                
            case .failure(let error):
                Utility.printToConsole(message: error)
                completion(false, error)
            }
        }
    }
}
