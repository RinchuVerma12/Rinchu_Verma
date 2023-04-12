//
//  CollectionCell.swift
//  ShoppingApp
//
//  Created by Rinchu on 13/02/23.
//

import UIKit

class SelectProfileImageVCCollectionCell: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var addPhoto: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
//    var imageSelectionHandler: ((_ index: Int)->())?
//    var index = 0
    //MARK:- XIB Life Cycle Method
    override func awakeFromNib() {
        super.awakeFromNib()
        addPhoto.layer.cornerRadius = addPhoto.frame.height/2
        imageView.layer.cornerRadius = 10
        addPhoto.layer.borderWidth = 2
    }

    //MARK: - Helper Methods
    func setimage(_ img:String){
        imageView.image = UIImage(named: img)
    }
    
//    @IBAction func btnPlusAction(_ sender: Any) {
//        if let handler = imageSelectionHandler {
//            handler(index)
//        }
//    }
    
}
