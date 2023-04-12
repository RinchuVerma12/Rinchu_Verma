//
//  Constants.swift
//  RedimateIOSCode
//
//  Created by Mudasir Ahmad on 22/03/2023.
//

import Foundation
import UIKit

let IS_IPHONE = UIDevice.init().userInterfaceIdiom == .phone
let IS_IPAD = UIDevice.init().userInterfaceIdiom == .pad
let IS_IPHONE_5  =  (IS_IPHONE && UIScreen.main.bounds.height == 568.0)
let IS_IPHONE_8  =  (IS_IPHONE && UIScreen.main.bounds.height == 667)
let IS_IPHONE_8PLUS = (IS_IPHONE && UIScreen.main.bounds.height == 736.0)
let IS_IPHONE_X   =  (IS_IPHONE && UIScreen.main.bounds.height == 812.0)
let IS_IPHONE_XR  =  (IS_IPHONE && UIScreen.main.bounds.height == 896.0)
