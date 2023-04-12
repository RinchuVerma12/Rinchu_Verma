//
//  FifthVC.swift
//  ShoppingApp
//
//  Created by Rinchu on 14/02/23.
//

import UIKit
import Foundation
import Photos

let SCREEN_WIDTH = UIScreen.main.bounds.width

class SelectProfileImageVC: UIViewController, UINavigationControllerDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var continueBtn: UIButton!
    //-----------------------------------------------------//
    
    //MARK: - Properties and Datastructure
    var imageArray = ["0","1","2","3","4","5","6","1","2"]
    let myPickerController = UIImagePickerController()
    var checkForImageSelection = false
//    var selectedImage = UIImage()
//    var compressedImage: UIImage?
    
    //MARK: - USER DATA
    var data5 = OnBoardViewModel()
    //-----------------------------------------------------//
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    //-----------------------------------------------------//
    
    
    //MARK: - Helper Methods
    private func initialize(){
        continueBtn.backgroundColor = UIColor(red: 255/255, green: 215/255, blue: 214/255, alpha: 1.0)
        collectionView.register(UINib(nibName: "SelectProfileImageVCCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SelectProfileImageVCCollectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        continueBtn.layer.cornerRadius = 15
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

    //196736
    //MARK: - Save data Locally
    func saveDataLocally(){
        UserDefaults.standard.setValue(data5.email, forKey: "email")
        UserDefaults.standard.setValue(data5.password, forKey: "password")
        UserDefaults.standard.setValue(data5.name, forKey: "name")
        UserDefaults.standard.setValue(data5.dob, forKey: "dob")
        UserDefaults.standard.setValue(data5.gender, forKey: "gender")
        UserDefaults.standard.setValue(data5.showGenderOnProfileOrNot, forKey: "showGender")
        guard let data = data5.profileImage?.jpegData(compressionQuality: 0.5) else { return }
            let encoded = try! PropertyListEncoder().encode(data)
       UserDefaults.standard.setValue(encoded, forKey: "profileImage")
    }
    
    //MARK: - Actions
    @IBAction func moveToHome(_ sender: UIButton) {
        if checkForImageSelection {
            saveDataLocally()
            DispatchQueue.main.async {
                SceneDelegate().setHomeAsRootVC()
            }
                
                         
        }
    }
    //-----------------------------------------------------//
    
    @IBAction func selectProfileImageVCbackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openGalleryAction(_ sender: UIButton) {
        self.myPickerController.allowsEditing = true
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            let alertMessage = UIAlertController(title: nil,message:"Select option", preferredStyle:.actionSheet)
            let cameraAction = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default, handler:
                                                {
                                                    action in
                                                     self.cameraClick()
                                                })
            
            let galleryAction = UIAlertAction(title: NSLocalizedString("Gallery", comment: ""), style: .default, handler:
                                                {
                                                    action in
                                                     self.photoLibrary()
                                                })
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .destructive , handler:
                                                {
                                                    
                                                    (alert: UIAlertAction!) -> Void in
                                                })
            
            alertMessage.addAction(cameraAction)
            alertMessage.addAction(galleryAction)
            alertMessage.addAction(cancelAction)
            
            self.present(alertMessage, animated: true, completion: nil)
        }
        
    }
    
    func  cameraClick() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // The user has previously granted access to the camera.
                DispatchQueue.main.async {
                    self.openCamera()
                }
            case .notDetermined: // The user has not yet been asked for camera access.
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        DispatchQueue.main.async {
                            self.openCamera()
                        }
                    }
                }
            case .denied: // The user has previously denied access.
                // return
                cameraAccess()
                
            case .restricted: // The user can't grant access due to restrictions.
                // return
                cameraAccess()
            @unknown default:
                return
            }
        }
        else {
            
            let alertMessage = UIAlertController(title:"Alert",message:"Camera not present",preferredStyle:.alert)
            
            alertMessage.addAction(UIAlertAction(title:"Ok",style:.default,handler:nil))
            
            self.present(alertMessage,animated:true,completion:nil)
        }
    }
    
    func photoLibrary() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            DispatchQueue.main.async {
                self.openGallery()
            }
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {

                    DispatchQueue.main.async {
                        self.openGallery()
                    }
                }
            })
            print("It is not determined until now")
            
        case .limited:
            return
        case .restricted:
            // same same
            //  print("User do not have access to photo album.")
            self.galleryAccess()
        case .denied:
            // same same
            //print("User has denied the permission.")
            self.galleryAccess()
            
        @unknown default:break
        }
    }

    func openCamera() {
        myPickerController.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        self.myPickerController.sourceType = UIImagePickerController.SourceType.camera
        myPickerController.allowsEditing = true
        self.present(myPickerController, animated: true, completion: nil)
    }
        
        
    func cameraAccess() {
        
        let myAlertVC = UIAlertController(title: "Camera access is denied earlier, go to settings to access camera", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let yesAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (action) in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        myAlertVC.addAction(yesAction)
        myAlertVC.addAction(settingsAction)
        
        present(myAlertVC, animated: true, completion: nil)
    }
    
    func openGallery() {
        myPickerController.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        myPickerController.sourceType = .savedPhotosAlbum
//        myPickerController.mediaTypes
        myPickerController.videoMaximumDuration = 0.0
        myPickerController.allowsEditing = true
        self.present(myPickerController, animated: true, completion: nil)
    }

    func galleryAccess() {
        let myAlertVC = UIAlertController(title: "Gallery access is denied earlier, go to settings to access photos", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let yesAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (action) in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        myAlertVC.addAction(yesAction)
        myAlertVC.addAction(settingsAction)
        
        present(myAlertVC, animated: true, completion: nil)
    }
    //-----------------------------------------------------//
    
}
//-----------------------------------------------------//

//MARK: - Extension for FifthVC
extension SelectProfileImageVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageArray.count
    }
    //-----------------------------------------------------//
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectProfileImageVCCollectionCell", for: indexPath) as! SelectProfileImageVCCollectionCell
        data5.profileImage = UIImage(named: imageArray[indexPath.item])
        cell.setimage(imageArray[indexPath.item])
        cell.addPhoto.tag = indexPath.item
        cell.addPhoto.addTarget(self, action: #selector(addPhoto(sender:)), for: .touchUpInside)
        return cell
    }
    //-----------------------------------------------------//
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = SCREEN_WIDTH/4
        return CGSize(width: width, height: 170)
    }
    //-----------------------------------------------------//
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    //-----------------------------------------------------//
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    //-----------------------------------------------------//
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        data5.profileImage = UIImage(named: imageArray[indexPath.item])
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 1
        cell?.layer.borderColor = UIColor.black.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0
        cell?.layer.borderColor = UIColor.white.cgColor
    }
    //-----------------------------------------------------//
    
    //MARK: - Add Photo Action
    @objc func addPhoto(sender:UIButton){
        let index = IndexPath(row: sender.tag, section: 0)
        let cell = collectionView.cellForItem(at: index) as! SelectProfileImageVCCollectionCell
        if(cell.addPhoto.image(for: .normal) == UIImage(systemName: "plus")){
            cell.addPhoto.setImage(UIImage(named:"write"), for: .normal)
        }
        else{
            cell.addPhoto.setImage(UIImage(systemName:"plus"), for: .normal)
        }
    }
}


extension SelectProfileImageVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.editedImage] as? UIImage {
            data5.profileImage = img
            
        } else if let img = info[.originalImage] as? UIImage {
            data5.profileImage = img
        }
        
        self.dismiss(animated: true, completion: nil)
        if(data5.profileImage != nil){
            checkForImageSelection = true
        continueBtn.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 121/255, alpha: 1.0)
        }
    }
}
