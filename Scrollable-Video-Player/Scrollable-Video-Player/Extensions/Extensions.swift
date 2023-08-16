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
        return UIColor(red: 15.0 / 255.0, green: 6.0 / 255.0, blue: 23.0 / 255.0, alpha: 1.0)
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
