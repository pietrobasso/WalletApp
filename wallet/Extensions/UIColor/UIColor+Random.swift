//
//  UIColor+Random.swift
//  lisca
//
//  Created by Pietro Basso on 26/04/2018.
//  Copyright © 2018 Rawfish. All rights reserved.
//

import UIKit

extension UIColor {
    /// Returns a color object using the specified opacity and random RGB component values.
    class func random(alpha: CGFloat = 1.0) -> UIColor {
        let random = { CGFloat.random(in: 0...1) }
        return UIColor.init(red: random(), green: random(), blue: random(), alpha: alpha)
    }
}
