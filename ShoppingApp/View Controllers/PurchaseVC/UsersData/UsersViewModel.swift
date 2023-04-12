//
//  UsersViewModel.swift
//  ShoppingApp
//
//  Created by Rinchu on 27/03/23.
//

import Foundation
class UsersViewModel{
        
    var userData = [Users]()
    
    func getUsers(completion: @escaping (Bool, Error?) -> ()) {
        APIHandler.opertationWithRequest(withApi: .Users) { (result: Result<[Users], Error>) in
            switch result {
            case .success(let object):
                self.userData = object
                completion(true, nil)
                
            case .failure(let error):
                Utility.printToConsole(message: error)
                completion(false, error)
            }
        }
    }
}
