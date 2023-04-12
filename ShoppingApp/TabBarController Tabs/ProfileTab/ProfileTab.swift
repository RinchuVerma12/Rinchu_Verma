//
//  ProfileTab.swift
//  ShoppingApp
//
//  Created by Rinchu on 13/03/23.
//

import Foundation
import UIKit

class ProfileTab: UIViewController{
    
    //MARK: - Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var pushNotification: UISwitch!
    override func viewDidLoad() {
        initialize()
    }
    
    //MARK: - Life Cycle Method
    private func initialize(){
        let name = UserDefaults.standard.string(forKey: "name")
//        let image = UserDefaults.standard.string(forKey: "profileImage")
        pushNotification.isOn = false
        guard let data = UserDefaults.standard.data(forKey: "profileImage") else { return }
            let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
            let image = UIImage(data: decoded)
        print("After",image!)
        profileImage.image = image
        profileImage.layer.cornerRadius = 20
        welcomeText.text = "Welcome, " + name!
    }
    
    //MARK: - Action
    @IBAction func showPersonalInfo(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let showPersonalInfo = storyboard.instantiateViewController(identifier: "PersonalInfo")
        self.navigationController?.pushViewController(showPersonalInfo, animated: true)
    }
    
    @IBAction func allowPushNotifications(_ sender: UISwitch) {
        if sender.isOn{
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge,.sound,.alert]){ (granted,error) in
                if error == nil{
                    print("User permission is granted: \(granted)")
                }
            }
            
            let content = UNMutableNotificationContent()
            content.title = "Local Notifications"
            content.body = "Local Notification content Body"
            content.sound = .default
         
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            
            let uuid = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
            
            center.add(request){(error) in
                if error != nil {
                        // handle error
                    }
            }
        }
    }
}
