//
//  CartCollectionCell.swift
//  ShoppingApp
//
//  Created by Rinchu on 20/02/23.
//

import UIKit
var initialPrice = ""
class ShoppingCartVCCollectionCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var imageOnShoppingCart: UIImageView!
    @IBOutlet weak var cartCell: UIView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemCategory: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemStyle: UILabel!
    @IBOutlet weak var decrementBtn: UIButton!
    @IBOutlet weak var incrementBtn: UIButton!
    @IBOutlet weak var checkBtn: UIButton!
    
    //MARK: -Additional property
 
    
    //MARK: XIB Life Cycle Method
    override func awakeFromNib() {        
        super.awakeFromNib()
        cartCell.layer.cornerRadius = 25
        checkBtn.layer.cornerRadius = 15
        imageOnShoppingCart.layer.cornerRadius = 15
        //Adding Shadow
        addShadow()
       
    }
    
    func addShadow(){
        cartCell.clipsToBounds = true
        cartCell.layer.shadowRadius = 3
        cartCell.layer.shadowOpacity = 1.0
        cartCell.layer.shadowOffset = CGSize(width: 3, height: 3)
        cartCell.layer.shadowColor = UIColor.gray.cgColor
        cartCell.layer.masksToBounds = false
        
        imageOnShoppingCart.clipsToBounds = true
        imageOnShoppingCart.layer.shadowRadius = 3
        imageOnShoppingCart.layer.shadowOpacity = 1.0
        imageOnShoppingCart.layer.shadowOffset = CGSize(width: 3, height: 3)
        imageOnShoppingCart.layer.shadowColor = UIColor.gray.cgColor
        imageOnShoppingCart.layer.masksToBounds = false
    }

    //MARK: - Custom Methods
    func setData(_ image: String,_ title:String,_ style:String,_ price:Int){
        imageOnShoppingCart.image = UIImage(named: image)
        itemTitle.text = title
        itemPrice.text = String(price)
        itemStyle.text = style
        initialPrice =  (itemPrice.text!)
    }
}
