//
//  UserData.swift
//  ShoppingApp
//
//  Created by Rinchu on 28/03/23.
//

import UIKit

class UserDataVC: UIViewController {
    
    //MARK: - PROPERTIES
    var userPostsViewModel = UserPostsViewModel()
    var albumDataViewModel = UserAlbum()
    var ID = ""
    var segmentControlSelectedIndex = 0
    
    //MARK: - OUTLETS
    @IBOutlet weak var userDataVCTableView: UITableView!
    
    //MARK: - LIFE CYCLE METHOD
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        
    }
    
    
    
    //MARK: - HELPER METHOD
    private func initialize(){
        userDataVCTableView.delegate = self
        userDataVCTableView.dataSource = self
        
        userDataVCTableView.register(UINib(nibName: "PostsVCTableViewCell", bundle: nil), forCellReuseIdentifier: "PostsVCTableViewCell")
        
        
        userDataVCTableView.register(UINib(nibName: "AlbumsVCTableViewCell", bundle: nil), forCellReuseIdentifier: "AlbumsVCTableViewCell")
        
        userPostsViewModel.Id = ID
        getPostsFromAPI()
    }
    
    //MARK: - Action
    @IBAction func checkForWhichSegmentIsSelected(_ sender: UISegmentedControl) {
        
        segmentControlSelectedIndex = sender.selectedSegmentIndex
        if sender.selectedSegmentIndex == 1 {
            if albumDataViewModel.albumData.count == 0 {
                albumDataViewModel.Id = ID
                self.getAlbumsDataFromAPI()
            }
        }
        userDataVCTableView.reloadData()
    }
    
    //MARK:- Fetch Album Data
    func getAlbumsDataFromAPI() {
        Utility.showIndicator()
        albumDataViewModel.getAlbumsOfAUser { [weak self] success, error in
            guard let self = self else {return}
            if success {
                self.userDataVCTableView.reloadData()
                
            } else {
                Utility.printToConsole(message: error!)
            }
            
            Utility.hideIndicator()
        }
        
    }
    
    //MARK:- Fetch PostsVC Data
    func getPostsFromAPI() {
        Utility.showIndicator()
        userPostsViewModel.getPostsOfAUser { [weak self] success, error in
            guard let self = self else {return}
            if success {
                self.userDataVCTableView.reloadData()
                
            } else {
                Utility.printToConsole(message: error!)
            }
            
            Utility.hideIndicator()
        }
        

        
        
    }
    
    //MARK: - ACTION
    @IBAction func userDataVCBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension UserDataVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentControlSelectedIndex == 0 {
            return userPostsViewModel.userPosts.count
        }
        else{
            return albumDataViewModel.albumData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if segmentControlSelectedIndex == 0{
            let cell = userDataVCTableView.dequeueReusableCell(withIdentifier: "PostsVCTableViewCell") as! PostsVCTableViewCell
            cell.selectionStyle = .none
            cell.setPostVCData(userPostsViewModel.userPosts[indexPath.row])
            return cell
        }
        else{
            let cell = userDataVCTableView.dequeueReusableCell(withIdentifier: "AlbumsVCTableViewCell") as! AlbumsVCTableViewCell
            cell.selectionStyle = .none
            cell.setAlbumData(albumDataViewModel.albumData[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentControlSelectedIndex == 0{
            let storyBoard = UIStoryboard(name: "Users", bundle: nil)
            let userPostCommentsVC = storyBoard.instantiateViewController(withIdentifier: "UserCommentsVC") as! UserCommentsVC
            userPostCommentsVC.ID = "\(userPostsViewModel.userPosts[indexPath.row].id)"
            userPostCommentsVC.headerTitle = userPostsViewModel.userPosts[indexPath.row].title
            userPostCommentsVC.headerBody = userPostsViewModel.userPosts[indexPath.row].body
            self.navigationController?.pushViewController(userPostCommentsVC, animated: true)
        }
        else{
            let storyBoard = UIStoryboard(name: "Users", bundle: nil)
            let userAlbumsVC = storyBoard.instantiateViewController(withIdentifier: "AlbumPhotoVC") as! AlbumPhotoVC
            userAlbumsVC.ID = "\(albumDataViewModel.albumData[indexPath.row].id)"
            self.navigationController?.pushViewController(userAlbumsVC, animated: true)
        }
    }
    
    
}
