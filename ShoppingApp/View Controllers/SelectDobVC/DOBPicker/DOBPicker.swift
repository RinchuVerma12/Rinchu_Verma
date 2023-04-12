//
//  DOBPicker.swift
//  NordicStrong
//
//  Created by Mudasir on 15/01/23.
//

import UIKit

class DOBPicker: UIView {
    
    //MARK: - Outlet
    @IBOutlet weak var tapView: UIView!
    @IBOutlet weak var calanderView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //MARK: - Properties
    var dobSelectionHandler: ((_ date: Date)->())?
    var cancelHandler: (()->())?
    var selectedDate = Date()
    
    //MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        tapView.addGestureRecognizer(tapGesture)
        
        //This is added to select pre-selected date from picker. Value change event is not fired if user selects already selected date
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(datePickerTapped(_:)))
        tapGesture1.cancelsTouchesInView = false
        datePicker.addGestureRecognizer(tapGesture1)
    }
    
    @objc func viewTapped() {
        if let handler = cancelHandler {
            handler()
        }
    }
    
    @objc func datePickerTapped(_ touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: self.datePicker)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            
            if self.selectedDate > Date() {
                return
            }
            
            if touchPoint.y > 60 {
                if let handler = self.dobSelectionHandler {
                    handler(self.datePicker.date)
                }
            }
        }
    }
    
    
    //MARK: - Action
    @IBAction func dateSelected(_ sender: UIDatePicker) {
        print(sender.date)
        
        selectedDate = sender.date
        
        if selectedDate > Date() {
//            HelpingVC.shared.showAlert(message: Constants.Alert_Messages.invalidDate)
            return
        }
        
        datePicker = sender
        
        if let handler = dobSelectionHandler {
            handler(sender.date)
        }
    }
}
