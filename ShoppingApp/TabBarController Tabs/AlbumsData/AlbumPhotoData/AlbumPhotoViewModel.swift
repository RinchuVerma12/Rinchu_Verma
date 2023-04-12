//
//  AlbumPhotoViewModel.swift
//  ShoppingApp
//
//  Created by Rinchu on 30/03/23.
//

import Foundation
class AlbumPhotoViewModel {
    
    var albumPhotoData = [AlbumPhoto]()
    var Id = ""
    func getAlbumPhotoData(completion: @escaping (Bool, Error?) -> ()) {
        APIHandler.opertationWithRequest(withApi: .AlbumPhotos(id: Id)) { (result: Result<[AlbumPhoto], Error>) in
            switch result {
            case .success(let object):
                self.albumPhotoData = object
                completion(true, nil)
                
            case .failure(let error):
                Utility.printToConsole(message: error)
                completion(false, error)
            }
        }
    }
}


