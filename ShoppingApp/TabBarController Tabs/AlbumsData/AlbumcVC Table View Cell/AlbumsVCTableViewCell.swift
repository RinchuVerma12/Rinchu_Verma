//
//  AlbumsVCTableViewCell.swift
//  ShoppingApp
//
//  Created by Rinchu on 27/03/23.
//

import UIKit

class AlbumsVCTableViewCell: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var albumDataTableViewCellView: UIView!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var title: UILabel!
    
    //MARK: - XIB LIFE CYCLE METHOD
    override func awakeFromNib() {
        super.awakeFromNib()
        albumDataTableViewCellView.layer.cornerRadius = 20
        Utility.addingShadow(albumDataTableViewCellView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setAlbumData(_ model: Albums){
        self.userId.text = String(model.userId)
        self.id.text = String(model.id)
        self.title.text = model.title
    }
    
}
