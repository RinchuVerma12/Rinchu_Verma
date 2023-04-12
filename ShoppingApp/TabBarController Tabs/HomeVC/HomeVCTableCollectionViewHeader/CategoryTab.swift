//
//  CategoryTab.swift
//  ShoppingApp
//
//  Created by Rinchu on 27/02/23.
//

import UIKit

class CategoryTab: UICollectionViewCell {

    @IBOutlet weak var tabView: UIView!
    @IBOutlet weak var tab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tab.backgroundColor = UIColor(red: 223/255, green: 224/255, blue: 230/255, alpha: 1.0)
        tab.textColor = UIColor(red: 156/255, green: 165/255, blue: 180/255, alpha: 1.0)
        tabView.layer.cornerRadius = tabView.bounds.size.height/2
        
    }
    func setLabel(_ lbl:String){
        tab.text = lbl
    }
}
