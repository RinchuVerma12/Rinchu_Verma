//
//  SecondVC.swift
//  ShoppingApp
//
//  Created by Rinchu on 14/02/23.
//

import UIKit

class NameVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    //-----------------------------------------------------//
    
    //MARK: - USER DATA 
    var data2 = OnBoardViewModel()
    
    
    //MARK: - Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    //-----------------------------------------------------//
    
    //MARK: - Helper Methods
    private func initialize(){
        nameTF.becomeFirstResponder()
        nameTF.layer.cornerRadius = 15
        continueBtn.layer.cornerRadius = 15
        nameTF.text = UserDefaults.standard.string(forKey: "name")
        addingShadow()
        
        //MARK: - Tap Gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture))
        self.view.addGestureRecognizer(tapGesture)
    }
    //-----------------------------------------------------//
    @objc func handleTapGesture(){
        nameTF.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    func addingShadow(){
        continueBtn.clipsToBounds = true
        continueBtn.layer.shadowRadius = 3
        continueBtn.layer.shadowOpacity = 1.0
        continueBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
        continueBtn.layer.shadowColor = UIColor.systemPink.cgColor
        continueBtn.layer.masksToBounds = false
    }
    
    //-----------------------------------------------------//
    
    func isValidName(strToValidate: String) -> Bool {
        
        let nameValidationRegex = "^^[A-Za-z\\s]+$"
        let nameValidationPredicate = NSPredicate(format: "SELF MATCHES %@", nameValidationRegex)
        return nameValidationPredicate.evaluate(with: strToValidate)
        
    }
    //-----------------------------------------------------//
    func moveToSelectDobVC(){
        let storyboard = UIStoryboard(name: "OnBoardScreens", bundle: nil)
        let selectDobVC = storyboard.instantiateViewController(identifier: "SelectDobVC") as! SelectDobVC
        selectDobVC.data3 = data2
        selectDobVC.modalPresentationStyle = .fullScreen
        self.present(selectDobVC, animated: true, completion: nil)
    }
    //-----------------------------------------------------//
    
    //MARK: - Actions
    @IBAction func nameVCBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    //-----------------------------------------------------//
    
    @IBAction func moveToSelectDobVC(_ sender: UIButton) {
        let validName = isValidName(strToValidate: nameTF.text!)
        if(!validName || nameTF.text == nil || nameTF.text == ""){
            Utility.showAlert(message: "Name must contain only letters", title: "ShoppingApp")
        }
        else{
            data2.name = nameTF.text
            moveToSelectDobVC()
        }
    }
    
}
