//
//  ThirdVC.swift
//  ShoppingApp
//
//  Created by Rinchu on 14/02/23.
//

import UIKit

class SelectDobVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    //-----------------------------------------------------//
    
    //MARK: - Additional properties
    var datePicker: UIDatePicker?
    var dobView: DOBPicker?
    //-----------------------------------------------------//
    
    //MARK: - USER DATA
    var data3 = OnBoardViewModel()
    
    //Mark: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    //-----------------------------------------------------//
    
    //MARK: Custom Methods
    func initialize(){
        continueBtn.layer.cornerRadius = 15
        dateLbl.layer.borderColor = UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 1.0).cgColor
        dateLbl.layer.borderWidth = 1.0
        dateLbl.text = UserDefaults.standard.string(forKey: "dob")
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
    
    func setdateIntextField(dob: Date) {
        let now = Date()
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let currentDate = dateFormatter.string(from: now)
        let selectedDate: String = dateFormatter.string(from: dob)
        
        var start = currentDate.index(currentDate.startIndex, offsetBy: 0)
        var end = currentDate.index(currentDate.endIndex, offsetBy: -8)
        var result = currentDate[start..<end]
        guard let currentDay = Int(result) else{return}
        
        start = currentDate.index(currentDate.startIndex, offsetBy: 3)
        end = currentDate.index(currentDate.endIndex, offsetBy: -5)
        result = currentDate[start..<end]
        guard let currentMonth = Int(result) else{return}
        
        start = currentDate.index(currentDate.startIndex, offsetBy: 6)
        result = currentDate[start...]
        guard let currentYear = Int(result) else{return}
        
        start = selectedDate.index(selectedDate.startIndex, offsetBy: 0)
        end = selectedDate.index(selectedDate.endIndex, offsetBy: -8)
        result = selectedDate[start..<end]
        guard let selectedDay = Int(result) else{return}
        
        start = selectedDate.index(selectedDate.startIndex, offsetBy: 3)
        end = selectedDate.index(selectedDate.endIndex, offsetBy: -5)
        result = selectedDate[start..<end]
        guard let selectedMonth = Int(result) else{return}
        
        start = selectedDate.index(selectedDate.startIndex, offsetBy: 6)
        result = selectedDate[start...]
        guard let selectedYear = Int(result) else{return}
        
        //MARK: - Check for invalid date
        if(selectedYear > currentYear){
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            })
            dateLbl.text = nil
        }
        else{
            if(selectedYear < currentYear){
                dateLbl.text = selectedDate
            }
            else{
                if(selectedMonth > currentMonth){
                    //                    datePicker.isHidden = true
                    DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    })
                    
                    dateLbl.text = nil
                }
                else{
                    if(selectedMonth < currentMonth){
                        dateLbl.text = selectedDate
                    }
                    else{
                        if(selectedDay > currentDay){
                            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                                
                            })
                            dateLbl.text = nil
                        }
                        else{
                            dateLbl.text = selectedDate
                        }
                    }
                }
            }
        }
    }
    //-----------------------------------------------------//
    
    func moveToSelectGenderVC(){
        let storyboard = UIStoryboard(name: "OnBoardScreens", bundle: nil)
        let selectGenderVC = storyboard.instantiateViewController(identifier: "SelectGenderVC") as! SelectGenderVC
        selectGenderVC.data4 = data3
        selectGenderVC.modalPresentationStyle = .fullScreen
        self.present(selectGenderVC, animated: true, completion: nil)
    }
    //-----------------------------------------------------//
    
    //MARK: - Actions
    
    @IBAction func selectDobVCBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    //-----------------------------------------------------//
    
    
    @IBAction func moveToSelectGenderVC(_ sender: UIButton) {
        if(dateLbl.text != nil){
            data3.dob = dateLbl.text
            moveToSelectGenderVC()
        }
    }
    //-----------------------------------------------------//
    
    @IBAction func pickDate(_ sender: UIButton) {
        if dobView == nil {
            dobView = Bundle.main.loadNibNamed("DOBPicker", owner: self, options: nil)?.first as? DOBPicker
            dobView?.frame = self.view.frame
            UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.addSubview(dobView ?? UIView())
            
            dobView?.cancelHandler = { [weak self] in
                guard let self = self else {return}
                self.dobView?.isHidden = true
            }
            
            dobView?.dobSelectionHandler = { [weak self] date in
                guard let self = self else {return}
                
                self.setdateIntextField(dob: date)
                self.dobView?.isHidden = true
            }
        } else {
            self.dobView?.isHidden = false
        }
    }
    //-----------------------------------------------------//
    
    //MARK: - Objective-C function for date field
    @objc func dateValueChanged(sender: UIDatePicker) {
        
        let now = Date()
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let currentDate = dateFormatter.string(from: now)
        let selectedDate: String = dateFormatter.string(from: sender.date)
        
        var start = currentDate.index(currentDate.startIndex, offsetBy: 0)
        var end = currentDate.index(currentDate.endIndex, offsetBy: -8)
        var result = currentDate[start..<end]
        guard let currentDay = Int(result) else{return}
        
        start = currentDate.index(currentDate.startIndex, offsetBy: 3)
        end = currentDate.index(currentDate.endIndex, offsetBy: -5)
        result = currentDate[start..<end]
        guard let currentMonth = Int(result) else{return}
        
        start = currentDate.index(currentDate.startIndex, offsetBy: 6)
        result = currentDate[start...]
        guard let currentYear = Int(result) else{return}
        
        start = selectedDate.index(selectedDate.startIndex, offsetBy: 0)
        end = selectedDate.index(selectedDate.endIndex, offsetBy: -8)
        result = selectedDate[start..<end]
        guard let selectedDay = Int(result) else{return}
        
        start = selectedDate.index(selectedDate.startIndex, offsetBy: 3)
        end = selectedDate.index(selectedDate.endIndex, offsetBy: -5)
        result = selectedDate[start..<end]
        guard let selectedMonth = Int(result) else{return}
        
        start = selectedDate.index(selectedDate.startIndex, offsetBy: 6)
        result = selectedDate[start...]
        guard let selectedYear = Int(result) else{return}
        
        //MARK: - Check for invalid date
        if(selectedYear > currentYear){
            dateLbl.text = nil
        }
        else{
            if(selectedYear < currentYear){
                dateLbl.text = selectedDate
            }
            else{
                if(selectedMonth > currentMonth){
                    dateLbl.text = nil
                }
                else{
                    if(selectedMonth < currentMonth){
                        dateLbl.text = selectedDate
                    }
                    else{
                        if(selectedDay > currentDay){
                            dateLbl.text = nil
                        }
                        else{
                            dateLbl.text = selectedDate
                        }
                    }
                }
            }
        }
    }
    
}

