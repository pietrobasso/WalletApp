//
//  TabCoordinator.swift
//  lisca-iOS
//
//  Created by Pietro Basso on 14/02/2019.
//  Copyright © 2019 Rawfish. All rights reserved.
//

import UIKit

protocol TabProvider {
    var tabController: UITabBarController { get }
    
    func addTab(coordinator: Coordinator, animated: Bool)
    func removeTab(coordinator: Coordinator)
}

extension TabProvider where Self: Coordinator {
    func addTab(coordinator: Coordinator, animated: Bool = true) {
        add(child: coordinator)
        var viewControllers = tabController.viewControllers ?? []
        viewControllers.append(coordinator.viewController)
        tabController.setViewControllers(viewControllers, animated: animated)
    }
    
    func removeTab(coordinator: Coordinator) {
        remove(child: coordinator)
        if let index = tabController.viewControllers?.index(where: { $0 === coordinator.viewController }) {
            tabController.viewControllers?.remove(at: index)
        }
    }
}

typealias TabCoordinator = Coordinator & TabProvider
