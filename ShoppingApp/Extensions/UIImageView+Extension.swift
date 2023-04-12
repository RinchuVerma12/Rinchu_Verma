//
//  UIImageView+Extension.swift
//  ShoppingApp
//
//  Created by Rinchu on 31/03/23.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView{

    func nspImageLoader(url: URL, placeholder:UIImage?, shouldProcess:Bool = false, shouldAddBlurEffect:Bool = false, completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
           
           var options:KingfisherOptionsInfo = [
               .scaleFactor(UIScreen.main.scale),
               .transition(.fade(0.1))
           ]
           
           if shouldProcess && shouldAddBlurEffect{
               options = [.processor(BlackWhiteProcessor()),
                           .scaleFactor(UIScreen.main.scale),
                          .transition(.fade(0.1)),
                          .cacheOriginalImage
               ]
           }
        
        if shouldAddBlurEffect {
            let processor = BlurImageProcessor(blurRadius: 3.0)
            options.append(.processor(processor))
            
        }
           
           self.kf.setImage(
               with: url,
               placeholder: placeholder,
               options: options, completionHandler:
                   {
                       result in
                       completionHandler?(result)
                   })
           
       }
}
