//
//  CellHeader.swift
//  ShoppingApp
//
//  Created by Rinchu on 27/02/23.
//

import UIKit

class HomeVCTableViewHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var headerView: UIView!
    override func awakeFromNib() {
        headerView.layer.cornerRadius = 30
    }
}
