//
//  HighlightedButton.swift
//  wallet
//
//  Created by Pietro Basso on 15/02/2019.
//  Copyright © 2019 Pietro Basso. All rights reserved.
//

import UIKit

class HighlightedButton: UIButton, Highlightable {
    override var isHighlighted: Bool {
        didSet {
            set(isHighlighted: isHighlighted)
        }
    }
    
    func set(isHighlighted: Bool) {
        backgroundColor = isHighlighted ? backgroundColor?.withAlphaComponent(0.7) : backgroundColor?.withAlphaComponent(1)
    }
}
