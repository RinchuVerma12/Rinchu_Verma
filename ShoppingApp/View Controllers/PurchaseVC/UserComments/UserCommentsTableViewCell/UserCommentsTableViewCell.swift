//
//  UserComments.swift
//  ShoppingApp
//
//  Created by Rinchu on 29/03/23.
//

import UIKit

class UserCommentsTableViewCell: UITableViewCell {

    //MARK: - OUTLETS
  

    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblId: UILabel!
  

    @IBOutlet weak var UserCommentsTableViewCellView: UIView!
    @IBOutlet weak var lblImage: UILabel!
   
    
    //MARK: - XIB LIFE CYCLE METHOD
    override func awakeFromNib() {
        super.awakeFromNib()
        lblImage.layer.cornerRadius = lblImage.frame.width/2
        UserCommentsTableViewCellView.layer.cornerRadius = 20
        Utility.addingShadow(UserCommentsTableViewCellView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: - HELPER METHOD
    func setUserComments(_ model: UserComments){
        lblId.text = "\(model.id)"
        lblComment.text = model.body
    }
    
}
