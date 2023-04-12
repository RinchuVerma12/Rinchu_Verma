//
//  UsersVC.swift
//  ShoppingApp
//
//  Created by Rinchu on 27/03/23.
//

import UIKit

class UsersVC: UIViewController {
    
   
    //MARK: - PROPERTIES
    var usersViewModel = UsersViewModel()
    var postsViewModel = PostsViewModel()
    var albumsViewModel = AlbumDataViewModel()
    var todosViewModel = TODOViewModel()
    var userCommentsViewModel = UserCommentsViewModel()
    var albumPhotoViewModel = AlbumPhotoViewModel()
    var viewToShow: ViewToShow = .users

 
    //MARK: - OUTLETS
    @IBOutlet weak var usersVCTableView: UITableView!
    
    //MARK: VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initialze()
    }
    
    //MARK: - HELPER METHODS
    private func initialze(){
        usersVCTableView.delegate = self
        usersVCTableView.dataSource = self
        
        switch(viewToShow){
        case .users:
            usersVCTableView.register(UINib(nibName: "UsersVCTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersVCTableViewCell")
            getUsersDataFromAPI()
            
        case .posts:
            usersVCTableView.register(UINib(nibName: "PostsVCTableViewCell", bundle: nil), forCellReuseIdentifier: "PostsVCTableViewCell")
            getPostsFromAPI()
            
        case .albums:
            usersVCTableView.register(UINib(nibName: "AlbumsVCTableViewCell", bundle: nil), forCellReuseIdentifier: "AlbumsVCTableViewCell")
            getAlbumsDataFromAPI()
            
        case .todos:
            usersVCTableView.register(UINib(nibName: "TODOTableViewCell", bundle: nil), forCellReuseIdentifier: "TODOTableViewCell")
            getTODOSFromAPI()
            
        }
        usersVCTableView.estimatedRowHeight = UITableView.automaticDimension
        
    }
    
    //MARK:- Fetch PostsVC Data
    func getPostsFromAPI() {
        Utility.showIndicator()
        postsViewModel.getPosts { [weak self] success, error in
            guard let self = self else {return}
            if success {
                self.usersVCTableView.reloadData()
                
            } else {
                Utility.printToConsole(message: error!)
            }
            
            Utility.hideIndicator()
        }
        
    }
    
    //MARK:- Fetch TODO Data
    func getTODOSFromAPI() {
        Utility.showIndicator()
        todosViewModel.getTodos { [weak self] success, error in
            guard let self = self else {return}
            if success {
                self.usersVCTableView.reloadData()
                
            } else {
                Utility.printToConsole(message: error!)
            }
            
            Utility.hideIndicator()
        }
        
    }
    //MARK: - Fetching User Details from API
    func getUsersDataFromAPI(){
        Utility.showIndicator()
        usersViewModel.getUsers{ [weak self] success, error in
            guard let self = self else{return}
            
            if success{
                self.usersVCTableView.reloadData()
            }
            else{
                Utility.printToConsole(message: error!)
            }
            Utility.hideIndicator()
        }
        
    }
    
    
    //MARK: - Fetching Album Details from API
    func getAlbumsDataFromAPI(){
        Utility.showIndicator()
        albumsViewModel.getAlbums{ [weak self] success, error in
            guard let self = self else{return}
            
            if success{
                self.usersVCTableView.reloadData()
            }
            else{
                Utility.printToConsole(message: error!)
            }
        }
        Utility.hideIndicator()
    }
    
    
    //MARK: - ACTIONS
    @IBAction func moveToMenu(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension UsersVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewToShow == .users{
            return usersViewModel.userData.count
        }else if viewToShow == .posts{
            return postsViewModel.postsData.count
        }
        else if viewToShow == .albums{
            return albumsViewModel.albumData.count
        }
        else{
            return todosViewModel.todoData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewToShow == .users{
            let cell = usersVCTableView.dequeueReusableCell(withIdentifier: "UsersVCTableViewCell") as! UsersVCTableViewCell
            cell.selectionStyle = .none
            cell.setUserDetails(usersViewModel.userData[indexPath.row])
            return cell
        }
        
        else if viewToShow == .posts{
            let cell = usersVCTableView.dequeueReusableCell(withIdentifier: "PostsVCTableViewCell", for: indexPath) as! PostsVCTableViewCell
            cell.selectionStyle = .none
            cell.setPostVCData(postsViewModel.postsData[indexPath.row])
            return cell
        }
        else if viewToShow == .albums{
            let cell = usersVCTableView.dequeueReusableCell(withIdentifier: "AlbumsVCTableViewCell", for: indexPath) as! AlbumsVCTableViewCell
            cell.selectionStyle = .none
            cell.setAlbumData(albumsViewModel.albumData[indexPath.row])
            return cell
        }else{
            let cell = usersVCTableView.dequeueReusableCell(withIdentifier: "TODOTableViewCell", for: indexPath) as! TODOTableViewCell
            cell.selectionStyle = .none
            cell.setTodoData(todosViewModel.todoData[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewToShow == .users{
            
            let storyBoard = UIStoryboard(name: "Users", bundle: nil)
            
            let userDataVC = storyBoard.instantiateViewController(withIdentifier: "UserDataVC") as! UserDataVC
            
            let id = usersViewModel.userData[indexPath.row].id
            userDataVC.ID = String(id)
            self.navigationController?.pushViewController(userDataVC, animated: true)
            
        }
        if viewToShow == .posts{
            let storyBoard = UIStoryboard(name: "Users", bundle: nil)
            
            let userCommentsVC = storyBoard.instantiateViewController(withIdentifier: "UserCommentsVC") as! UserCommentsVC
            
            let id = postsViewModel.postsData[indexPath.row].id
            let title = postsViewModel.postsData[indexPath.row].title
            let body = postsViewModel.postsData[indexPath.row].body
            
            userCommentsVC.ID = String(id)
            userCommentsVC.headerBody = body
            userCommentsVC.headerTitle = title
            
            self.navigationController?.pushViewController(userCommentsVC, animated: true)
        }
        if viewToShow == .albums{
            let storyBoard = UIStoryboard(name: "Users", bundle: nil)
            
            let albumPhotoVC = storyBoard.instantiateViewController(withIdentifier: "AlbumPhotoVC") as! AlbumPhotoVC
            
            let id = albumsViewModel.albumData[indexPath.row].id
            albumPhotoVC.ID = String(id)
       
            self.navigationController?.pushViewController(albumPhotoVC, animated: true)
        }
    }
    
}
