//
//  ShoppingCartVC.swift
//  ShoppingApp
//
//  Created by Rinchu on 20/02/23.
//

import UIKit

//MARK: - Additinal Properties
var price = ""
class ShoppingCartVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var shoppingCartVCImage1: UIButton!
    @IBOutlet weak var shoppingCartVCImage2: UIButton!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var shoppingCartCollectionCell: UICollectionView!
    @IBOutlet weak var payNowBtn: UIButton!
    
    //MARK: - Structure Variable
    var data = CartItemData()
   
    var imageArray: [String] = []
    var titleArray: [String] = []
    var priceArray: [Int] = []
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //279111
    //MARK: - Helper Methods
    private func initialize(){
        
        imageArray = UserDefaults.standard.object(forKey: "CartImages") as! [String]
        titleArray = UserDefaults.standard.object(forKey: "ItemTitles") as! [String]
        priceArray = UserDefaults.standard.object(forKey: "ItemPrices") as! [Int]
        
        shoppingCartVCImage1.layer.cornerRadius = shoppingCartVCImage1.frame.width/2
        shoppingCartVCImage2.layer.cornerRadius = shoppingCartVCImage2.frame.width/2
        payNowBtn.layer.cornerRadius = 25
        
        guard let data = UserDefaults.standard.data(forKey: "profileImage") else { return }
             let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
             let image = UIImage(data: decoded)
        shoppingCartVCImage2.setImage(image, for: .normal)
        
        shoppingCartCollectionCell.register(UINib(nibName: "ShoppingCartVCCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ShoppingCartVCCollectionCell")
        shoppingCartCollectionCell.delegate = self
        shoppingCartCollectionCell.dataSource = self
        
        //        addShadow()
        self.navigationController?.isNavigationBarHidden = true
    }
    func addShadow(){
        payNowBtn.clipsToBounds = true
        payNowBtn.layer.shadowRadius = 10
        payNowBtn.layer.shadowOpacity = 1.0
        payNowBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
        payNowBtn.layer.shadowColor = UIColor.systemPink.cgColor
        payNowBtn.layer.masksToBounds = false
    }
    //MARK: - Action
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}



// MARK: - Extension for ShoppingCartVC
extension ShoppingCartVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingCartVCCollectionCell", for: indexPath) as! ShoppingCartVCCollectionCell
//        cell.setData(data.image, data.title, data.style, data.price)
        cell.setData(imageArray[indexPath.item],titleArray[indexPath.item],data.style,priceArray[indexPath.item])
        
        imageArray = UserDefaults.standard.object(forKey: "CartImages") as! [String]
        titleArray = UserDefaults.standard.object(forKey: "ItemTitles") as! [String]
        priceArray = UserDefaults.standard.object(forKey: "ItemPrices") as! [Int]
        
        imageArray.append(data.image)
        titleArray.append(data.title)
        priceArray.append(data.price)
        
        UserDefaults.standard.setValue(imageArray,forKey: "CartImages")
        UserDefaults.standard.setValue(titleArray,forKey: "ItemTitles")
        UserDefaults.standard.setValue(priceArray,forKey: "ItemPrices")
        
        cell.incrementBtn.tag = indexPath.item
        cell.incrementBtn.addTarget(self, action: #selector(increment(sender:)), for: .touchUpInside)
        cell.incrementBtn.tag = indexPath.item
        cell.decrementBtn.addTarget(self, action: #selector(decrement(sender:)), for: .touchUpInside)
        
        price = cell.itemPrice.text!
        totalAmount.text = "$\(price)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: SCREEN_WIDTH, height: 110)
    }
    
    //MARK: - Custom Methods
    @objc func increment(sender:UIButton){
        let index = IndexPath(row: sender.tag, section: 0)
        let cell = shoppingCartCollectionCell.cellForItem(at: index) as! ShoppingCartVCCollectionCell
        guard let a = Int(cell.itemQuantity.text!) else{
            return
        }
        guard let price = Int(initialPrice) else {
            return
        }
        
    
        
        cell.itemPrice.text = "\(price * a + price)"
        cell.itemQuantity.text = "\(a+1)"
        totalAmount.text = "$" + cell.itemPrice.text!
        
        
    }
    
    @objc func decrement(sender:UIButton){
        let index = IndexPath(row: sender.tag, section: 0)
        let cell = shoppingCartCollectionCell.cellForItem(at: index) as! ShoppingCartVCCollectionCell
        guard let a = Int(cell.itemQuantity.text!) else{
            return
        }
        guard let price = Int(initialPrice) else {
            return
        }
        
        
        cell.itemPrice.text = "\(price * a - price)"
        if a<2 {
            cell.itemQuantity.text = "1"
            cell.itemPrice.text = "\(initialPrice)"
        }
        else{
            cell.itemQuantity.text = "\(a-1)"
        }
        totalAmount.text = "$" + cell.itemPrice.text!
    }
}
