//
//  NoDelayCollectionView.swift
//  wallet
//
//  Created by Pietro Basso on 17/02/2019.
//  Copyright © 2019 Pietro Basso. All rights reserved.
//

import UIKit

class NoDelayCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        delaysContentTouches = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        return true
    }
}
