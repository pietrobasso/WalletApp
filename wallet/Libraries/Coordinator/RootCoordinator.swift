//
//  RootCoordinator.swift
//  lisca-iOS
//
//  Created by Pietro Basso on 14/02/2019.
//  Copyright © 2019 Rawfish. All rights reserved.
//

import UIKit

/// A root coordinator is a special coordinator which holds a UIWindow.
typealias RootCoordinator = Coordinator & WindowProvider

protocol WindowProvider: class {
    var window: UIWindow { get }
}

extension WindowProvider where Self: Coordinator {
    func switchTo(coordinator: Coordinator) {
        remove(children: childrenCoordinators)
        add(child: coordinator)
        window.rootViewController = coordinator.viewController
        window.makeKeyAndVisible()
        coordinator.start()
    }
}
