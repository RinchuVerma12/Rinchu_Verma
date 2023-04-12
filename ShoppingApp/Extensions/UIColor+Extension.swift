//
//  UIColor+Extension.swift
//  AppTask2
//
//  Created by Ashu on 28/03/23.
//

import Foundation
import UIKit

extension UIColor {
    
    static var appDarkBlue = UIColor(named: "darkBlue")!
    static var appGrayText = UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1.0)
    
    class func viewwBorderColor() -> UIColor {
        return UIColor.colorWithHexString(hexStr: "#E1E1E1")
    }
    
    class func colorWithHexString(hexStr: String) -> UIColor {
        var cString:String = hexStr.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (hexStr.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if (cString.isEmpty || (cString.count) != 6) {
            return colorWithHex(rgbValue: 0xFF5300);
        } else {
            var rgbValue:UInt64 = 0
            Scanner(string: cString).scanHexInt64(&rgbValue)
            return colorWithHex(rgbValue: UInt32(rgbValue));
        }
    }
    
    class func colorWithHex(rgbValue: UInt32) -> UIColor {
        return UIColor( red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                        alpha: CGFloat(1.0))
    }
    
}
