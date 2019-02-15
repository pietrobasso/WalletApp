//
//  ShrinkableButton.swift
//  wallet
//
//  Created by Pietro Basso on 15/02/2019.
//  Copyright © 2019 Pietro Basso. All rights reserved.
//

import UIKit

class ShrinkableButton: UIButton, Shrinkable {
    override var isHighlighted: Bool {
        didSet {
            set(isShrinked: isHighlighted)
        }
    }
    
    func set(isShrinked: Bool) {
        let transform = isShrinked ? CGAffineTransform(scaleX: 0.92, y: 0.92) : CGAffineTransform(scaleX: 1, y: 1)
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: isShrinked ? .curveEaseOut : .curveEaseIn,
                       animations: { [weak self] in
                        self?.transform = transform
                        self?.layoutIfNeeded()
            }, completion: nil)
    }
}

class ShrinkableGradientButton: UIButton, Shrinkable, Gradientable {
    
    // MARK: - Views
    
    var gradientLayer: CAGradientLayer? {
        didSet {
            guard let gradientLayer = gradientLayer else { return }
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            set(isShrinked: isHighlighted)
        }
    }
    override func layoutSublayers(of layer: CALayer) {
        gradientLayer?.frame = bounds
        super.layoutSublayers(of: layer)
    }
    
    func set(isShrinked: Bool) {
        let transform = isShrinked ? CGAffineTransform(scaleX: 0.92, y: 0.92) : CGAffineTransform(scaleX: 1, y: 1)
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: isShrinked ? .curveEaseOut : .curveEaseIn,
                       animations: { [weak self] in
                        self?.transform = transform
                        self?.layoutIfNeeded()
            }, completion: nil)
    }
}
