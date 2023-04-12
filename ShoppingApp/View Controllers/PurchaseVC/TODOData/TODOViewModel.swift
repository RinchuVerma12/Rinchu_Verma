//
//  TODOViewModel.swift
//  ShoppingApp
//
//  Created by Rinchu on 29/03/23.
//

import Foundation
class TODOViewModel {
    
    var todoData = [TODO]()
    
    func getTodos(completion: @escaping (Bool, Error?) -> ()) {
        APIHandler.opertationWithRequest(withApi: .TODO) { (result: Result<[TODO], Error>) in
            switch result {
            case .success(let object):
                self.todoData = object
                completion(true, nil)
                
            case .failure(let error):
                Utility.printToConsole(message: error)
                completion(false, error)
            }
        }
    }
}
