//
//  HomeVC.swift
//  ShoppingApp
//
//  Created by Rinchu on 20/02/23.
//

import UIKit
//MARK: - Structure
struct ShoppingCartData{
    var image = ""
    var title = ""
    var style = ""
    var price = 0
}
//-----------------------------------------------------//

class HomeVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var homeVCCollectionView: UICollectionView!
    @IBOutlet weak var itemListCollectionView: UICollectionView!
    @IBOutlet weak var homeVCImage1: UIButton!
    @IBOutlet weak var homeVCImage2: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLbl: UILabel!
    
    //MARK: - Properties and Datastructure
    let itemImage = ["shoe1","shoe2","shoe3","shoe7","shoe5","shoe6","shoe7"]
    let itemTitle = ["shoe1","shoe2","shoe3","shoe4","shoe5","shoe6","shoe7"]
    let itemPrice = [1000,2000,1500,230,2365,2131,1230]
    var firstName: String = ""
    
    
    var imageArray: [String] = []
    var titleArray: [String] = []
    var priceArray: [Int] = []
    
    //MARK: - Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: - Helper Methods
    private func initialize(){
       
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeVCTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "HomeVCTableViewHeader")
        tableView.register(UINib(nibName: "HomeVCTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeVCTableViewCell")
        
        homeVCImage1.layer.cornerRadius = homeVCImage1.frame.width/2
        homeVCImage2.layer.cornerRadius = homeVCImage2.frame.width/2
        filterBtn.layer.cornerRadius = 8
        
        //MARK: - USER DATA
        let name  = UserDefaults.standard.string(forKey: "name") ?? ""
        guard let data = UserDefaults.standard.data(forKey: "profileImage") else { return }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        let image = UIImage(data: decoded)
        
        //MARK: - Extracting the first name
        for i in name{
            if i == " "{
                break
            }
            firstName.append(i)
        }
        
        homeVCImage2.setImage(image, for: .normal)
        nameLbl.text = "Hello " + firstName
        
        self.navigationController?.isNavigationBarHidden = true
        
        //MARK: - Tap Gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapGesture() {
        self.searchBar.endEditing(true)
    }
    //-----------------------------------------------------//
    
    //MARK: - Action
    @IBAction func logout(_ sender: Any) {
        
        let logoutAlert = UIAlertController(title: "ShoppingApp", message: "Want to LOGOUT?", preferredStyle: UIAlertController.Style.alert)
        
        logoutAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            DispatchQueue.main.async {
                SceneDelegate().logUserOut()
            }
                
        }))
        
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        
        self.present(logoutAlert, animated: true, completion: nil)
    }    
}
//-----------------------------------------------------//

//MARK: - Extension for HomeVC
extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeVCTableViewCell", for: indexPath) as? HomeVCTableViewCell else{
            return UITableViewCell()
        }
        cell.registerCollectionViewCell()
        
        cell.cellSelectHandler = { [weak self] index in
            guard let self = self else {return}
            
            let storyboard = UIStoryboard(name: "Purchase", bundle: nil)
            let purchaseVC = storyboard.instantiateViewController(identifier: "PurchaseVC") as! PurchaseVC
            purchaseVC.data = ShoppingCartData(image: self.itemImage[index], title: self.itemTitle[index], style: "Shoes", price: self.itemPrice[index])
            self.navigationController?.pushViewController(purchaseVC, animated: true)
            
            self.imageArray.append(purchaseVC.data.image)
            self.titleArray.append(purchaseVC.data.title)
            self.priceArray.append(purchaseVC.data.price)
            
            UserDefaults.standard.setValue(self.imageArray,forKey: "CartImages")
            UserDefaults.standard.setValue(self.titleArray,forKey: "ItemTitles")
            UserDefaults.standard.setValue(self.priceArray,forKey: "ItemPrices")
            
        }
        
        
        return cell
    }
    //-----------------------------------------------------//
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    //-----------------------------------------------------//
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeVCTableViewHeader") as? HomeVCTableViewHeader else{
            return UIView()
        }
        return header
    }
    //-----------------------------------------------------//
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        200
    }
    //-----------------------------------------------------//
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}









