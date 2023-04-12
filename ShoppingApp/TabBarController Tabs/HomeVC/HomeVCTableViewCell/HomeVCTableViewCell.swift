//
//  TableCell.swift
//  ShoppingApp
//
//  Created by Rinchu on 27/02/23.
//

import UIKit


class HomeVCTableViewCell: UITableViewCell {

    //MARK: - Datastructure and properties
    let itemImage = ["shoe1","shoe2","shoe3","shoe7","shoe5","shoe6","shoe7"]
    let itemTitle = ["shoe1","shoe2","shoe3","shoe4","shoe5","shoe6","shoe7"]
    let itemPrice = [1000,2000,1500,230,2365,2131,1230]
    
    //MARK: - Closure variable
    var cellSelectHandler: ((_ index: Int)->())?
    
    //MARK: - Outlets
 
    @IBOutlet weak var homeVCTableCellTableView: UICollectionView!
    
    //MARK: - XIB Life Cycle Method
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //Mark:- Custom Method
    func registerCollectionViewCell() {
        homeVCTableCellTableView.register(UINib(nibName: "HomeVCTableCollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeVCTableCollectionViewHeader")
        homeVCTableCellTableView.register(UINib(nibName: "HomeVCTableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeVCTableCollectionViewCell")
        
        homeVCTableCellTableView.dataSource = self
        homeVCTableCellTableView.delegate = self
    }
    
}

//MARK: - Extension for TableCell
extension HomeVCTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeVCTableCollectionViewCell", for: indexPath) as? HomeVCTableCollectionViewCell else {return UICollectionViewCell()}
        cell.setImage(itemImage[indexPath.item])
        cell.setTitle(itemTitle[indexPath.item])
        cell.setPrice(itemPrice[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH/2-10, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = homeVCTableCellTableView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeVCTableCollectionViewHeader", for: indexPath) as! HomeVCTableCollectionViewHeader
        if kind == UICollectionView.elementKindSectionHeader{
            return header
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: SCREEN_WIDTH, height: 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let handler = cellSelectHandler {
            handler(indexPath.item)
        }
    }
    
}

