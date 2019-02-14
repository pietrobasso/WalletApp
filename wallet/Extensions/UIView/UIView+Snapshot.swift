//
//  UIView+Snapshot.swift
//  wallet
//
//  Created by Pietro Basso on 14/02/2019.
//  Copyright © 2019 Pietro Basso. All rights reserved.
//

import UIKit

extension UIView  {
    func makeSnapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
