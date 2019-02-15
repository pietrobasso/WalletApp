//
//  CAGradientLayer.swift
//  wallet
//
//  Created by Pietro Basso on 15/02/2019.
//  Copyright © 2019 Pietro Basso. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    convenience init(frame: CGRect, colors: [CGColor], startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0), endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0), locations: [NSNumber]? = nil) {
        self.init()
        self.frame = frame
        self.colors = colors
        self.locations = locations
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
}
