//
//  AnimatedView.swift
//  ShoppingApp
//
//  Created by Rinchu on 14/03/23.
//

import UIKit

class AnimatedView: UIView {
    
    @IBOutlet weak var animatedView: UIView!
    override func awakeFromNib() {
        animatedView.layer.cornerRadius = animatedView.frame.height/2

                
        }

    }


