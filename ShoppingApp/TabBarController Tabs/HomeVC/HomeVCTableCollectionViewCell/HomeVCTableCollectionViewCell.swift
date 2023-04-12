//
//  ItemList.swift
//  ShoppingApp
//
//  Created by Rinchu on 20/02/23.
//

import UIKit

//Mark: - Structure
struct WishListData{
    let image = ""
    let title = ""
    let price = 0
}

class HomeVCTableCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Structure Variable
    var data = WishListData()
    
    //MARK: - Outlets
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var refreshBtn: UIButton!
    @IBOutlet weak var cellContentView: UIView!
    
    
    //MARK: - XIB Life Cycle Method
    override func awakeFromNib() {
        super.awakeFromNib()
        refreshBtn.layer.cornerRadius = refreshBtn.frame.width/2
        itemImage.layer.cornerRadius = 20
        
        //Adding Shadow
        addShadow()
    }
    
    func addShadow(){
        itemImage.clipsToBounds = true
        itemImage.layer.shadowRadius = 5
        itemImage.layer.shadowOpacity = 1.0
        itemImage.layer.shadowOffset = CGSize(width: 3, height: 3)
        itemImage.layer.shadowColor = UIColor.gray.cgColor
        itemImage.layer.masksToBounds = false
    }
    
    func setImage(_ img: String){
        itemImage.image = UIImage(named: img)
    }
    
    func setTitle(_ lbl:String){
        itemTitle.text = lbl
    }
    
    func setPrice(_ price:Int){
        itemPrice.text = "$"+String(price)
    }
}
