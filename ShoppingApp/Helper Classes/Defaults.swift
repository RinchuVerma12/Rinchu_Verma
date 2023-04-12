////
////  Defaults.swift
////  ShoppingApp
////
////  Created by Rinchu on 03/03/23.
////
//
//import Foundation
//
//enum DefaultKey {
//    case user
//}
//
//class Defaults {
//    // MARK: - SingleTon
//    static let shared = Defaults()
//
//    // MARK: - Variables
//    let userDefault = UserDefaults.standard
//
//    // MARK: - Setter
//    func set(value:Any,  forKey key:DefaultKey) {
//        userDefault.set(value, forKey: String(describing: key))
//        userDefault.synchronize()
//    }
//
//    // MARK: - Getter
//    func get(forKey key:DefaultKey) -> Any? {
//        return userDefault.object(forKey: String(describing: key))
//    }
//
//    // MARK: - Methods
//    func removeAll() {
//        Defaults.shared.remove(.user)
//    }
//
//    func remove(_ key:DefaultKey) {
//        userDefault.removeObject(forKey: String(describing: key))
//        userDefault.synchronize()
//    }
//
//
//    func saveCurrentUser(user: OnBoardViewModel) {
//        do {
//            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false)
//            Defaults.shared.set(value: encodedData, forKey: .user)
//
//        } catch _ {
//
//        }
//    }
//
//    func getCurrentUser() -> OnBoardViewModel? {
//        guard let userData = Defaults.shared.get(forKey: .user) as? Data, let user = NSKeyedUnarchiver.unarchiveObject(with: userData) as? OnBoardViewModel  else {
//            return nil
//        }
//        return user
//    }
//}
