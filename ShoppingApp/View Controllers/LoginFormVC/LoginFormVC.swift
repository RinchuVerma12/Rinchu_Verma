//
//  ViewController.swift
//  ShoppingApp
//
//  Created by Rinchu on 13/02/23.
//

import UIKit

class LoginFormVC: UIViewController, UIAlertViewDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginFormView: UIView!
    //-----------------------------------------------------//
    
    //MARK: - Additinal Properties
    var validEmail:Bool?
    var validPassword:Bool?
    //-----------------------------------------------------//
    
    //MARK: - USER DATA 
    var data1 = OnBoardViewModel()
    
    var View: AnimatedView?
    
    //MARK: - Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    //-----------------------------------------------------//
    
    //MARK: - Helper Methods
    private func initialize(){
        emailTF.becomeFirstResponder()
        emailTF.layer.cornerRadius = 15
        continueBtn.layer.cornerRadius = 15
        signUpBtn.layer.cornerRadius = 15
        passwordTF.layer.cornerRadius = 15
        
        //MARK: - Tap Gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture))
        self.view.addGestureRecognizer(tapGesture)
        
        //MARK: - Long Press Gesture
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressActionPerformed(sender:)))
        signUpBtn.addGestureRecognizer(longPressGesture)
    }
    
    @objc func longPressActionPerformed(sender:UILongPressGestureRecognizer){
        
        
        switch sender.state{
        case .began:
            showViewWithAnimation()
            
        case .ended:
              viewToRemove()
            break
        default:
            break
        }
    }
    
    //MARK: - Show View With Animation
    func showViewWithAnimation(){
        if View == nil {
            View = Bundle.main.loadNibNamed("AnimatedView", owner: self, options: nil)?.first as? AnimatedView
            View?.frame = CGRect(x: 0, y: 0, width: 200, height:200)
            View?.center = self.loginFormView.center
            self.view.addSubview(View ?? UIView())
            View?.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
        
        
        UIView.animate(withDuration: 1, delay: 0, animations: {
            self.View?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }){ (finished) in

//            self.perform(#selector(self.viewToRemove), with: nil, afterDelay: 1.0)
        }
    }
    
    //MARK: - Remove View With Animation
    func viewToRemove(){

        
        UIView.animate(withDuration: 1, delay: 0.1, animations: {
            self.View?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }){ (finished) in
//            DispatchQueue.main.async {
                self.View?.removeFromSuperview()
                self.View = nil
//            }
            
        }

    }
    
    func addingShadow(){
        signUpBtn.clipsToBounds = true
        signUpBtn.layer.shadowRadius = 3
        signUpBtn.layer.shadowOpacity = 1.0
        signUpBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
        signUpBtn.layer.shadowColor = UIColor.blue.cgColor
        signUpBtn.layer.masksToBounds = false
        continueBtn.clipsToBounds = true
        continueBtn.layer.shadowRadius = 3
        continueBtn.layer.shadowOpacity = 1.0
        continueBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
        continueBtn.layer.shadowColor = UIColor.systemPink.cgColor
        continueBtn.layer.masksToBounds = false
    }
    
    @objc func handleTapGesture() {
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        self.view.endEditing(true)
    }
    //-----------------------------------------------------//
    
    //MARK: - ERROR ALERTS

    
    //-----------------------------------------------------//
    
    func isValidEmailAddr(strToValidate: String) -> Bool {
        
        let emailValidationRegex = "^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: strToValidate)
        
    }
    
    //-----------------------------------------------------//
    
    func isValidPassword(strToValidate: String) -> Bool {
        
        let passwordValidateRegex = "^.*(?=.{8,}).*$"
        let passwordValidationPredicate = NSPredicate(format: "SELF MATCHES %@", passwordValidateRegex)
        return passwordValidationPredicate.evaluate(with: strToValidate)
        
    }
    //-----------------------------------------------------//
    
    func moveToHomeVC(){
        let storyboard = UIStoryboard(name: "OnBoardScreens", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "HomeVC") as! HomeVC
        secondVC.modalPresentationStyle = .fullScreen
        self.present(secondVC, animated: true, completion: nil)
    }
    //-----------------------------------------------------//
    
    func moveToSecondVC(){
        let storyboard = UIStoryboard(name: "OnBoardScreens", bundle: nil)
        let nameVC = storyboard.instantiateViewController(identifier: "NameVC") as! NameVC
        nameVC.data2 = data1
        nameVC.modalPresentationStyle = .fullScreen
        self.present(nameVC, animated: true, completion: nil)
    }
    //-----------------------------------------------------//
    
    //MARK: - Actions
    
    @IBAction func moveToNameVC(_ sender: UIButton) {
    
    if emailTF.text != nil && passwordTF.text != nil{
            
            
            validEmail = isValidEmailAddr(strToValidate: emailTF.text!)
            validPassword = isValidPassword(strToValidate: passwordTF.text!)
            if(!(validEmail!) && !(validPassword!)){
                Utility.showAlert(message: "Please enter valid email & correct password", title: "ShoppingApp")
            }
            else if(!(validEmail!) || emailTF.text == "" || emailTF.text == nil){
                Utility.showAlert(message: "Please enter correct email", title: "ShoppingApp")
            }
            else if(!(validPassword!) || passwordTF.text == "" || passwordTF.text == nil){
                Utility.showAlert(message: "Please enter correct password", title: "ShoppingApp")
            }
            else{
                data1.email = emailTF.text
                data1.password = passwordTF.text
                moveToSecondVC()
            }
        }
    }
    
    
}

