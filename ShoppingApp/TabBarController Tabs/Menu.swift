//
//  Menu.swift
//  ShoppingApp
//
//  Created by Rinchu on 27/03/23.
//

import UIKit
enum ViewToShow:Int{
    case users = 0
    case posts
    case albums
    case todos
}

//enum postsToShow:Int{
//    case userPosts
//    case posts
//}
class Menu: UIViewController {

    //MARK: - PROPERTIES
    //MARK: - VIEW CONTROLLER LIFE CYCLE METHOD
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

   //MARK:- ACTIONS
    @IBAction func showAllUsers(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Users", bundle: nil)
        let usersVC = storyBoard.instantiateViewController(withIdentifier: "UsersVC") as! UsersVC
        usersVC.viewToShow = .users
        self.navigationController?.pushViewController(usersVC, animated: true)
    }
    
    @IBAction func showAllPosts(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Users", bundle: nil)
        let usersVC = storyBoard.instantiateViewController(withIdentifier: "UsersVC") as! UsersVC
        usersVC.viewToShow = .posts
        self.navigationController?.pushViewController(usersVC, animated: true)
    }
    
    @IBAction func showAllAlbums(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Users", bundle: nil)
        let usersVC = storyBoard.instantiateViewController(withIdentifier: "UsersVC") as! UsersVC
        usersVC.viewToShow = .albums
        self.navigationController?.pushViewController(usersVC, animated: true)
    }
    
    @IBAction func showAllTodos(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Users", bundle: nil)
        let usersVC = storyBoard.instantiateViewController(withIdentifier: "UsersVC") as! UsersVC
        usersVC.viewToShow = .todos
        self.navigationController?.pushViewController(usersVC, animated: true)
    }
}
