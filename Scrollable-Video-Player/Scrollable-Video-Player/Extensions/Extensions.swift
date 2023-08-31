//
//  Extensions.swift
//  Scrollable-Video-Player
//
//  Created by Mohammad Sameer on 14/08/23.
//

import Foundation
import UIKit

extension UIColor {
    public static var surfacePrimary: UIColor {
        return UIColor(red: 0.059, green: 0.024, blue: 0.090, alpha: 1.0)
    }
    
    public static var progressFilled: UIColor {
        return UIColor(red: 0.655, green: 0.522, blue: 1.0, alpha: 1.0)
    }
    
    public static var progressEmpty: UIColor {
        return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.24)
    }
}

extension UIFont {
    static func notoSans(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        switch weight {
        case .medium:
            return UIFont(name: "NotoSans-Medium", size: size)!
        case .bold:
            return UIFont(name: "NotoSans-Bold", size: size)!
        default:
            return UIFont(name: "NotoSans-Regular", size: size)!
        }
    }
}
