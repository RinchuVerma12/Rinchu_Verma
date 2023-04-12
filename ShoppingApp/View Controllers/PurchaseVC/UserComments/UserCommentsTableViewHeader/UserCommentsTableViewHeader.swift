//
//  UserCommentsTableViewHeader.swift
//  ShoppingApp
//
//  Created by Rinchu on 31/03/23.
//

import UIKit

class UserCommentsTableViewHeader: UITableViewHeaderFooterView {

    //MARK: - OUTLETS
    @IBOutlet weak var userCommentsTableViewHeaderView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblCommentCount: UILabel!
  
    override class func awakeFromNib() {
       
        
    }
    
    func setHeaderData(_ title:String,_ description:String,_ count:Int){
        lblTitle.text = title
        lblDescription.text = description
        lblCommentCount.text = "\(count)"
    }

}
