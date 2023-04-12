//
//  AlbumPhotoTableViewCell.swift
//  ShoppingApp
//
//  Created by Rinchu on 30/03/23.
//

import UIKit

class AlbumPhotoTableViewCell: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var albumPhotoImageView: UIImageView!
    @IBOutlet weak var albumPhotoTableViewCellView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    //MARK: - XIB LIFE CYCLE METHOD
    override func awakeFromNib() {
        super.awakeFromNib()
        albumPhotoTableViewCellView.layer.cornerRadius = 20
        albumPhotoImageView.layer.cornerRadius = 20
        Utility.addingShadow(albumPhotoTableViewCellView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setAlbumPhotoData(_ model : AlbumPhoto){
        
        if let strImg = model.url {
            if let url = URL(string: strImg.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
                        self.albumPhotoImageView.nspImageLoader(url: url, placeholder: nil)
                    }
                }
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: model.url) {
//                        if let image = UIImage(data: data) {
//                            DispatchQueue.main.async {
//                                self?.albumPhotoImageView.image = image
//                            }
//                        }
//                    }
//                }
//        albumPhotoImageView.image = UIImage(named: model.url)
        lblId.text = "\(model.id)"
        lblTitle.text = model.title
    }
}
