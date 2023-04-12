//
//  UsersVCTableViewCell.swift
//  ShoppingApp
//
//  Created by Rinchu on 27/03/23.
//

import UIKit

class UsersVCTableViewCell: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var usersVCTableViewCellView: UIView!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblCatchPhrase: UILabel!
    @IBOutlet weak var lblBS: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Utility.addingShadow(usersVCTableViewCellView)
        usersVCTableViewCellView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
   
    func setUserDetails(_ model : Users){
        lblID.text = "\(model.id)"
        lblName.text = model.name
        lblUserName.text = model.username
        lblEmail.text = model.email
        lblPhone.text = model.phone
        lblWebsite.text = model.website
        lblAddress.text = "\(model.address.street)  \(model.address.suite)  \(model.address.city)  \(model.address.zipcode)"
        lblLocation.text = "\(model.address.geoLocation.lattitude) , \(model.address.geoLocation.longitude)"
        lblCompanyName.text = model.companyDetails.companyName
        lblCatchPhrase.text = model.companyDetails.catchPhrase
        lblBS.text = model.companyDetails.bs
    }
    
    func setAddressDetails(_ address:String){
        
    }
    
    func setGeoLocation(_ geo:String){
        
    }
    
    func setCompanyDetails(_ name: String,_ catchPhrase:String,_ bs:String){
        
    }
}
