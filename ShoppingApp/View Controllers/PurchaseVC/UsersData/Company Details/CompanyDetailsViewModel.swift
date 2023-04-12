//
//  CompanyDetailsViewModel.swift
//  ShoppingApp
//
//  Created by Rinchu on 27/03/23.
//

import Foundation

class CompanyDetailsViewModel{
    var companyDetails = [CompanyDetails]()
    
    func getCompanyDetails(completion: @escaping (Bool, Error?) -> ()) {
        APIHandler.opertationWithRequest(withApi: .Users) { (result: Result<[CompanyDetails], Error>) in
            switch result {
            case .success(let object):
                self.companyDetails = object
                completion(true, nil)
                
            case .failure(let error):
                Utility.printToConsole(message: error)
                completion(false, error)
            }
        }
    }
}
