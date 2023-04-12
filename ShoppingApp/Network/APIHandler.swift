//
//  APIHandler.swift
//  OverTimy
//
//  Created by Rather on 21/03/213.


import Foundation
import UIKit
import Alamofire

class APIHandler {
    
    init() {}
    class func opertationWithRequest<T>(withApi api:API,completion: @escaping (Result<T, Error>)->()) where T:Codable {
       
        if !(Alamofire.NetworkReachabilityManager()?.isReachable ?? false){
            Utility.showAlert(message: "Please check your internet connection.", title: "Alert")
            return
        }
      //  Utility.showLoader()
       let headers = api.headers
       let params = api.parameters
        
        let fullPath =  api.baseUrl + api.route
        let method = api.method
        let enco = api.encoding
        
        Utility.printToConsole(message: headers)
        Utility.printToConsole(message: fullPath)
        Utility.printToConsole(message: method)
        Utility.printToConsole(message: params)
    
        AF.request(fullPath, method: method, parameters: params, encoding:enco,headers:headers).responseJSON { response in
            switch response.result{
            case .success(let res):
                do {
                    Utility.printToConsole(message: res)
                    completion(.success(try JSONDecoder().decode(T.self, from: response.data ?? Data())))
                } catch let error {
                    
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    class func getTokenUDID() -> (String, String) {
        guard let token = UserDefaults.standard.value(forKey: "accessToken") as? String else {
            print("Token not found")
            return ("","")
        }
        
        guard let uuid = UserDefaults.standard.value(forKey: "UUID") as? String else {
            print("Uuid not found")
            return ("","")
        }
        
        return (token, uuid)
    }
}

//MARK: - Test Model
struct User : Codable {
    let name : String
    let email : String
    let id : Int
    let phone : String
    let username : String
    let website : String
}

//MARK:- HOW To USE
/*APIHandler.opertationWithRequest(withApi: .Test){
    (result: Result<[User],Error>) in
    switch result{
    case .success(let object):
        guard let userss = object as? [User] else{return}
        self.users = userss//userss.compactMap{$0}
        print(self.users)
    case .failure(let error):
        print(error)
    }
}
*/
