//
//  PurchaseVC.swift
//  ShoppingApp
//
//  Created by Rinchu on 20/02/23.
//

import UIKit

//MARK: - Structure
struct  CartItemData{
    var image = ""
    var title = ""
    var style = "Snickkers"
    var price = 0
}



class PurchaseVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var buyNowBtn: UIButton!
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var topViewBtn1: UIButton!
    @IBOutlet weak var topViewBtn2: UIButton!
    @IBOutlet weak var wishListImage: UIImageView!
    @IBOutlet weak var wishListItemPrice: UILabel!
    @IBOutlet weak var itemStyle: UILabel!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var wishListView: UIView!
    
    //MARK: - Structure Variable
    var data = ShoppingCartData()
    
    var image:[String] = []
    var itmPrice:[Int] = []
    var name:[String] = []
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()

    }

    //MARK: - Helper Methods
    func initialize(){
        buyNowBtn.layer.cornerRadius = 25
        addToCartBtn.layer.cornerRadius = addToCartBtn.frame.width/2
        topViewBtn1.layer.cornerRadius = topViewBtn1.frame.width/2
        topViewBtn2.layer.cornerRadius = topViewBtn2.frame.width/2
        wishListView.layer.cornerRadius = 50
        wishListImage.image = UIImage(named: data.image)
        wishListItemPrice.text = "$\(data.price)"
        itemTitle.text = data.title
        itemStyle.text = data.style
        
        //Adding Shadow To View
       addShadow()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func addShadow(){
        wishListView.clipsToBounds = true
        wishListView.layer.shadowRadius = 10
        wishListView.layer.shadowOpacity = 1.0
        wishListView.layer.shadowOffset = CGSize(width: 3, height: 3)
        wishListView.layer.shadowColor = UIColor.systemPink.cgColor
        wishListView.layer.masksToBounds = false

    }
    //MARK: - Actions
    @IBAction func moveToCart(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Purchase", bundle: nil)
        let cart = storyboard.instantiateViewController(identifier: "ShoppingCartVC") as! ShoppingCartVC
        cart.data = CartItemData(image: data.image, title: data.title, style: data.style, price: data.price)
        
        image.append(data.image)
        itmPrice.append(data.price)
        name.append(data.title)
        
        UserDefaults.standard.set(image, forKey: "cartItemImages")
        UserDefaults.standard.set(itmPrice, forKey: "cartItemPrices")
        UserDefaults.standard.set(name, forKey: "cartItemNames")
        
        cart.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(cart, animated: true)
    }
    
    @IBAction func moveToHome(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
