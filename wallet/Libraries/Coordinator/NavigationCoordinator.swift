//
//  NavigationCoordinator.swift
//  lisca-iOS
//
//  Created by Pietro Basso on 14/02/2019.
//  Copyright © 2019 Rawfish. All rights reserved.
//

import UIKit

protocol NavigationProvider {
    var navigationController: UINavigationController { get }
    
    func push(child: Coordinator, animated: Bool)
    func pop(child: Coordinator, animated: Bool)
}

extension NavigationProvider where Self: Coordinator {
    func push(child: Coordinator, animated: Bool = true) {
        add(child: child)
        navigationController.pushViewController(child.viewController, animated: animated)
    }
    
    func pop(child: Coordinator, animated: Bool = true) {
        if let coordinator = childrenCoordinators.first(where: { $0 === child }) {
            remove(child: coordinator)
            if coordinator.viewController.parent != nil {
                navigationController.popViewController(animated: animated)
            }
        }
    }
}

typealias NavigationCoordinator = Coordinator & NavigationProvider
