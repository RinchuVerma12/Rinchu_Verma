//
//  TODOTableViewCell.swift
//  ShoppingApp
//
//  Created by Rinchu on 29/03/23.
//

import UIKit

class TODOTableViewCell: UITableViewCell {

    //MARK: - PROPERTIES

    //MARK: - OUTLETS
    @IBOutlet weak var TODOVCTableViewCellView: UIView!
    @IBOutlet weak var completedSwitch: UISwitch!
    @IBOutlet weak var lblTitle: UILabel!
    
    //MARK: - XIB LIFE CYCLE METHOD
    override func awakeFromNib() {
        super.awakeFromNib()
        completedSwitch.isUserInteractionEnabled = false
        DispatchQueue.main.async {
            self.TODOVCTableViewCellView.layer.cornerRadius = self.TODOVCTableViewCellView.bounds.size.height/2
        }
        
        Utility.addingShadow(TODOVCTableViewCellView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setTodoData(_ model: TODO){
        lblTitle.text = model.title
        let completed = model.completed
        if completed == true{
            completedSwitch.isOn = true
        }else{
            completedSwitch.isOn = false
        }
    }
}
