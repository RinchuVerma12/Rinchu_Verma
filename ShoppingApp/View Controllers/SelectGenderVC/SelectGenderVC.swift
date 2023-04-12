//
//  FourthVC.swift
//  ShoppingApp
//
//  Created by Rinchu on 14/02/23.
//

import UIKit

class SelectGenderVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var womanLbl: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var manLbl: UILabel!
    @IBOutlet weak var womanIcon: UIButton!
    @IBOutlet weak var manIcon: UIButton!
    //-----------------------------------------------------//
    
    //MARK: - USER DATA
    var data4 = OnBoardViewModel()
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        
    }
    //-----------------------------------------------------//
    
    //MARK: - Custom Methods
    func initialize(){
        continueBtn.backgroundColor = UIColor(red: 255/255, green: 215/255, blue: 214/255, alpha: 1.0)
        continueBtn.layer.cornerRadius = 15
        let gender = UserDefaults.standard.string(forKey: "gender")
        let showGender = UserDefaults.standard.string(forKey: "showGender")
        if gender == "Female"{
            womanLbl.backgroundColor = UIColor(red: 255/255.0, green: 128/255.0, blue: 121/255.0, alpha: 1.0)
            womanIcon.backgroundColor = UIColor(red: 255/255.0, green: 128/255.0, blue: 121/255.0, alpha: 1.0)
            womanLbl.textColor = UIColor.white
            manLbl.backgroundColor = UIColor.white
            manLbl.textColor = UIColor.black
            manIcon.backgroundColor = UIColor.white
        }
        else if gender == "Male"{
            womanLbl.backgroundColor = UIColor.white
            manIcon.backgroundColor = UIColor(red: 171/255.0, green: 225/255.0, blue: 253/255.0, alpha: 1.0)
            manLbl.backgroundColor = UIColor(red: 171/255.0, green: 225/255.0, blue: 253/255.0, alpha: 1.0)
            womanIcon.backgroundColor = UIColor.white
            manLbl.textColor = UIColor.white
            womanLbl.textColor = UIColor.black
        }
        
        if showGender == "true"{
            checkBtn.setImage(UIImage(named: "check-mark"), for: .normal)
            
        }
        else if showGender == "false"{
            checkBtn.setImage(nil, for: .normal)
        }
        
        addingShadow()
    }
    //-----------------------------------------------------//
    
    func addingShadow(){
        continueBtn.clipsToBounds = true
        continueBtn.layer.shadowRadius = 3
        continueBtn.layer.shadowOpacity = 1.0
        continueBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
        continueBtn.layer.shadowColor = UIColor.systemPink.cgColor
        continueBtn.layer.masksToBounds = false
    }
    
    //-----------------------------------------------------//
    
    func moveToSelectProfileImageVC(){
        let storyboard = UIStoryboard(name: "OnBoardScreens", bundle: nil)
        let selectProfileImageVC = storyboard.instantiateViewController(identifier: "SelectProfileImageVC") as! SelectProfileImageVC
        selectProfileImageVC.data5 = data4
        selectProfileImageVC.modalPresentationStyle = .fullScreen
        self.present(selectProfileImageVC, animated: true, completion: nil)
    }
    //-----------------------------------------------------//
    
    //MARK: - Actions
    @IBAction func checkUncheckBtn(_ sender: UIButton) {
        
        if checkBtn.currentImage == UIImage(named:"check-mark"){
            checkBtn.setImage(nil, for: .normal)
            data4.showGenderOnProfileOrNot = true
        }
        else {
            checkBtn.setImage(UIImage(named: "check-mark"), for: .normal)
            data4.showGenderOnProfileOrNot = false
        }
    }
    //-----------------------------------------------------//
    
    @IBAction func womanRadioBtn(_ sender: UIButton) {
        womanLbl.backgroundColor = UIColor(red: 255/255.0, green: 128/255.0, blue: 121/255.0, alpha: 1.0)
        womanIcon.backgroundColor = UIColor(red: 255/255.0, green: 128/255.0, blue: 121/255.0, alpha: 1.0)
        womanLbl.textColor = UIColor.white
        manLbl.backgroundColor = UIColor.white
        manLbl.textColor = UIColor.black
        manIcon.backgroundColor = UIColor.white
        continueBtn.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 121/255, alpha: 1.0)
        data4.gender = "Female"
    }
    //-----------------------------------------------------//
    
    @IBAction func manRadioBtn(_ sender: UIButton) {
        womanLbl.backgroundColor = UIColor.white
        manIcon.backgroundColor = UIColor(red: 171/255.0, green: 225/255.0, blue: 253/255.0, alpha: 1.0)
        manLbl.backgroundColor = UIColor(red: 171/255.0, green: 225/255.0, blue: 253/255.0, alpha: 1.0)
        womanIcon.backgroundColor = UIColor.white
        manLbl.textColor = UIColor.white
        womanLbl.textColor = UIColor.black
        continueBtn.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 121/255, alpha: 1.0)
        data4.gender = "Male"
        
    }
    //-----------------------------------------------------//
    
   
    @IBAction func selectGenderVCBackBtn(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
    }
    //-----------------------------------------------------//
    
    
        
    @IBAction func moveToSelectProfileImageVC(_ sender: UIButton) {
    if data4.gender != nil{
        moveToSelectProfileImageVC()
        }
    }
}

