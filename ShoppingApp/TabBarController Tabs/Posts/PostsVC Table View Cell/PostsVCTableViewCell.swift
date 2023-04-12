//
//  PostCellTableViewCell.swift
//  ShoppingApp
//
//  Created by Ashu on 22/03/23.
//

import UIKit

class PostsVCTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var PostsVCTableViewCellView: UIView!
    
    @IBOutlet weak var lblPostUserId: UILabel!
    
    @IBOutlet weak var lblPostDescription: UILabel!
    @IBOutlet weak var lblPostTitle: UILabel!
    @IBOutlet weak var lblPostId: UILabel!
    //MARK: - XIB Life Cycle Method
    override func awakeFromNib() {
        super.awakeFromNib()
        PostsVCTableViewCellView.layer.cornerRadius = 30
        Utility.addingShadow(PostsVCTableViewCellView)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setPostVCData(_ model:Posts){
        lblPostId.text = "\(model.id)"
        lblPostUserId.text = "\(model.userId)"
        lblPostTitle.text = model.title
        lblPostDescription.text = model.body
    }
}
