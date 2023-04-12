//
//  GeoLocationViewModel.swift
//  ShoppingApp
//
//  Created by Rinchu on 27/03/23.
//

import Foundation
class GeoLocationViewModel{
    var geoLocationData = [GeoLocation]()
    
    func getUserGeoLocation(completion: @escaping (Bool, Error?) -> ()) {
        APIHandler.opertationWithRequest(withApi: .Users) { (result: Result<[GeoLocation], Error>) in
            
            switch result {
            case .success(let object):
                self.geoLocationData = object
                completion(true, nil)
                
            case .failure(let error):
                Utility.printToConsole(message: error)
                completion(false, error)
            }
        }
    }
    
}
