//
//  UserCommentsVC.swift
//  ShoppingApp
//
//  Created by Rinchu on 30/03/23.
//

import UIKit

class UserCommentsVC: UIViewController {
    
    //MARK: - PROPERTIES
var userCommentsViewModel = UserCommentsViewModel()
    
    //MARK: - PROPERTIES
    var ID = ""
    var headerTitle = ""
    var headerBody = ""
    var commentCount: Int?

    //MARK: - OUTLETS
    @IBOutlet weak var userCommentsVCTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()

    }
    
//MARK: - HELPER METHOD
    private func initialize(){
        userCommentsViewModel.id = ID
        userCommentsVCTableView.delegate = self
        userCommentsVCTableView.dataSource = self
       
            userCommentsVCTableView.register(UINib(nibName: "UserCommentsTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCommentsTableViewCell")
        userCommentsVCTableView.register(UINib(nibName: "UserCommentsTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "UserCommentsTableViewHeader")
        
            userCommentsViewModel.id = ID
            getUserCommentsDataFromAPI()
           
            
        
        
        userCommentsVCTableView.estimatedRowHeight = UITableView.automaticDimension
        userCommentsVCTableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
    }
    
    //MARK: - FETCHING USER COMMENTS FROM API
    func getUserCommentsDataFromAPI() {
        Utility.showIndicator()
        userCommentsViewModel.getUserComments { [weak self] success, error in
            guard let self = self else {return}
            if success {
                self.userCommentsVCTableView.reloadData()
                
            } else {
                Utility.printToConsole(message: error!)
            }
            
            Utility.hideIndicator()
        }
        
    }
    
    
    
    //MARK: - ACTION
    
    @IBAction func userCommentsVCBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension UserCommentsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       commentCount = userCommentsViewModel.userCommentsData.count
        return commentCount!
        

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = userCommentsVCTableView.dequeueReusableCell(withIdentifier: "UserCommentsTableViewCell") as! UserCommentsTableViewCell
            cell.setUserComments(userCommentsViewModel.userCommentsData[indexPath.row])
            cell.selectionStyle = .none
            return cell
        
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = userCommentsVCTableView.dequeueReusableHeaderFooterView(withIdentifier: "UserCommentsTableViewHeader") as! UserCommentsTableViewHeader
        header.setHeaderData(headerTitle,headerBody,commentCount!)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
}
