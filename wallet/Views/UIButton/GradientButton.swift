//
//  GradientButton.swift
//  wallet
//
//  Created by Pietro Basso on 15/02/2019.
//  Copyright © 2019 Pietro Basso. All rights reserved.
//

import UIKit

class GradientButton: UIButton, Gradientable {
    var gradientLayer: CAGradientLayer? {
        didSet {
            guard let gradientLayer = gradientLayer else { return }
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    override func layoutSublayers(of layer: CALayer) {
        gradientLayer?.frame = bounds
        super.layoutSublayers(of: layer)
    }
}
