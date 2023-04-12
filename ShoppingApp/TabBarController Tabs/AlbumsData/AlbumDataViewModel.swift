//
//  AlbumDataViewModel.swift
//  ShoppingApp
//
//  Created by Rinchu on 29/03/23.
//

import Foundation

class AlbumDataViewModel{
        
    var albumData = [Albums]()
    func getAlbums(completion: @escaping (Bool, Error?) -> ()) {
        APIHandler.opertationWithRequest(withApi: .Albums) { (result: Result<[Albums], Error>) in
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
