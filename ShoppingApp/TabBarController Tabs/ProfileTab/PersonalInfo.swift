//
//  PersonalInfo.swift
//  ShoppingApp
//
//  Created by Rinchu on 13/03/23.
//

import Foundation
import UIKit

class PersonalInfo: UIViewController{
    
    //MARK: - Outlets
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var gender: UILabel!
    
    //MARK: - Life Cycle Method
    override func viewDidLoad() {
        initialize()
    }
    
    //MARK: - Helper Method
    private func initialize(){
        name.text = UserDefaults.standard.string(forKey: "name")
        email.text = UserDefaults.standard.string(forKey: "email")
        dob.text = UserDefaults.standard.string(forKey: "dob")
        
        let showGender = UserDefaults.standard.string(forKey: "showGender")
        
        if (showGender != nil) == false{
            let gndr = UserDefaults.standard.string(forKey: "gender")
            gender.text = gndr!
        }
        else{
            gender.text = ""
        }
    }
    
    //MARK: - Action
    @IBAction func moveToPrevious(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
