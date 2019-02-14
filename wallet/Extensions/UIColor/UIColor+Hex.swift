//
//  UIColor+Hex.swift
//  lisca
//
//  Created by Rawfish on 08/08/2017.
//  Copyright © 2017 Rawfish. All rights reserved.
//

import UIKit

/*
 - When: Creating a custom color using hex values, without init(red:green:blue:alpha:) verbosity
 - Where: Extending UIColor to add a custom Color Scheme
 - Why: Type-safe way to instantiate custom colors in Swift: https://medium.com/ios-os-x-development/ios-extend-uicolor-with-custom-colors-93366ae148e6
 - Example: let terraCotta = UIColor.init(netHex: 0xE66B5B)
 */

extension UIColor {
    /// - parameters:
    ///     - red: Red component
    ///     - green: Green component
    ///     - blue: Blue component
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    /// Initialize an UIColor using an HEX color representation.
    ///
    ///     let white = UIColor(netHex: 0xffffff)
    ///
    /// - parameters:
    ///     - netHex: Hexadecimal (HEX) color value.
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
