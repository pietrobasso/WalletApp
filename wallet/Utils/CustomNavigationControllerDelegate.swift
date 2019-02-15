//
//  CustomNavigationControllerDelegate.swift
//  wallet
//
//  Created by Pietro Basso on 14/02/2019.
//  Copyright © 2019 Pietro Basso. All rights reserved.
//

import UIKit

/**
 Delegate that gets notified when we navigate between view controllers, without making the view controllers deal with the navigation controller and navigation bar.
 
 This makes these view controllers less smart about where they are used inside our architecture, and that's a good thing.
 
 - Authors:
 - [View Controller Refactoring](https://talk.objc.io/episodes/S01E43-view-controller-refactoring) by Chris Eidhof & Florian Kugler
 
 */
final class CustomNavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    let handler: (_ navigationController: UINavigationController, _ viewController: UIViewController, _ animated: Bool) -> ()
    
    init(handler: @escaping (_ navigationController: UINavigationController, _ viewController: UIViewController, _ animated: Bool) -> ()) {
        self.handler = handler
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        handler(navigationController, viewController, animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        handler(navigationController, viewController, animated)
    }
}

