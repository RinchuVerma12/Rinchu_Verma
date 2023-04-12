//
//  CollectionHeader.swift
//  ShoppingApp
//
//  Created by Rinchu on 27/02/23.
//

import UIKit

class HomeVCTableCollectionViewHeader: UICollectionReusableView {
    let tabs = ["All","Popular","Recent","Recommended"]
    @IBOutlet weak var collectionHeader: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    private func initialize(){
        collectionHeader.delegate = self
        collectionHeader.dataSource = self
        collectionHeader.register(UINib(nibName: "CategoryTab", bundle: nil), forCellWithReuseIdentifier: "CategoryTab")
        
        
    }
}

extension HomeVCTableCollectionViewHeader:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionHeader.dequeueReusableCell(withReuseIdentifier: "CategoryTab", for: indexPath) as! CategoryTab
        cell.setLabel(tabs[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionHeader.cellForItem(at: indexPath) as! CategoryTab
        cell.tab.textColor = UIColor.white
        cell.tab.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 121/255, alpha: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionHeader.cellForItem(at: indexPath) as! CategoryTab
        cell.tab.textColor = UIColor(red: 150/255, green: 160/255, blue: 176/255, alpha: 1.0)
        cell.tab.backgroundColor = UIColor(red: 227/255, green: 228/255, blue: 233/255, alpha: 1.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = tabs[indexPath.item].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        return CGSize(width: size.width + 50, height: collectionView.bounds.size.height)
    }
    
}
    

