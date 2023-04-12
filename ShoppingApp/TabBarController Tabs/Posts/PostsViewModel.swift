//
//  PostsViewModel.swift
//  ShoppingApp
//
//  Created by Ashu on 22/03/23.
//

import Foundation

class PostsViewModel {
    
    var postsData = [Posts]()
    
    func getPosts(completion: @escaping (Bool, Error?) -> ()) {
        APIHandler.opertationWithRequest(withApi: .Posts) { (result: Result<[Posts], Error>) in
            switch result {
            case .success(let object):
                self.postsData = object
                completion(true, nil)
                
            case .failure(let error):
                Utility.printToConsole(message: error)
                completion(false, error)
            }
        }
    }
}
