//
//  AlbumDataModel.swift
//  ShoppingApp
//
//  Created by Rinchu on 29/03/23.
//

import Foundation

class UserAlbum {
    
    var albumData = [Albums]()
    var Id = ""
    func getAlbumsOfAUser(completion: @escaping (Bool, Error?) -> ()) {
        APIHandler.opertationWithRequest(withApi: .UserAlbums(id: Id)) { (result: Result<[Albums], Error>) in
            switch result {
            case .success(let object):
                self.albumData = object
                completion(true, nil)
                
            case .failure(let error):
                Utility.printToConsole(message: error)
                completion(false, error)
            }
        }
    }
}
