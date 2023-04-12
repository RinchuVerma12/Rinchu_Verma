//
//  AlbumPhotoVC.swift
//  ShoppingApp
//
//  Created by Rinchu on 30/03/23.
//

import UIKit
//let SCREEN_WIDTh = UIScreen.main.bounds.width
class AlbumPhotoVC: UIViewController {
    
    //MARK: - PROPERTIES
    var albumPhotoViewModel = AlbumPhotoViewModel()
    var ID = ""
    
    //MARK: - OUTLETS
    @IBOutlet weak var AlbumPhotoVCTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        albumPhotoViewModel.Id = ID
        getAlbumPhotoDataFromAPI()
    }
    
    //MARK: - HELPER METHOD
    private func initialize(){
        AlbumPhotoVCTableView.delegate = self
        AlbumPhotoVCTableView.dataSource = self
        AlbumPhotoVCTableView.register(UINib(nibName: "AlbumPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "AlbumPhotoTableViewCell")
        AlbumPhotoVCTableView.estimatedRowHeight = UITableView.automaticDimension
            
    }
    
    //MARK: - FETCHING ALBUM PHOTO DATA FROM API
    func getAlbumPhotoDataFromAPI() {
        Utility.showIndicator()
        albumPhotoViewModel.getAlbumPhotoData { [weak self] success, error in
            guard let self = self else {return}
            if success {
                self.AlbumPhotoVCTableView.reloadData()
                
            } else {
                Utility.printToConsole(message: error!)
            }
            
            Utility.hideIndicator()
        }
        
    }
    
    //MARK: - ACTION
    @IBAction func albumPhotoVCBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}
extension AlbumPhotoVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albumPhotoViewModel.albumPhotoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AlbumPhotoVCTableView.dequeueReusableCell(withIdentifier: "AlbumPhotoTableViewCell") as! AlbumPhotoTableViewCell
        
        cell.setAlbumPhotoData(albumPhotoViewModel.albumPhotoData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
