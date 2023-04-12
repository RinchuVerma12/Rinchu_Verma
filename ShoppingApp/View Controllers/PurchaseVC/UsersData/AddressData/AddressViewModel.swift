//
//  AddressViewModel.swift
//  ShoppingApp
//
//  Created by Rinchu on 27/03/23.
//

import Foundation

class AddressViewModel{
    var userAddress = [UserAddress]()
    
    func getUserAddress(completion: @escaping (Bool, Error?) -> ()) {
        APIHandler.opertationWithRequest(withApi: .Users) { (result: Result<[UserAddress], Error>) in
            
            switch result {
            case .success(let object):
                self.userAddress = object
                completion(true, nil)
                
            case .failure(let error):
                Utility.printToConsole(message: error)
                completion(false, error)
            }
        }
    }
}
