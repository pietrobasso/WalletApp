//
//  AppCoordinator.swift
//  lisca-iOS
//
//  Created by Pietro Basso on 14/02/2019.
//  Copyright © 2019 Rawfish. All rights reserved.
//

import UIKit

/// The app coordinator is the root coordinator of the app. It holds the app main window on which it sets the view controllers of the main scenes, and it holds the app dependencies object.
class AppCoordinator: RootCoordinator {
    let window: UIWindow
    let dependencies: AppDependencies
    var childrenCoordinators: [Coordinator] = []
    let viewController: UIViewController = UIViewController()

    init(with window: UIWindow, dependencies: AppDependencies) {
        self.window = window
        self.dependencies = dependencies
    }
    
    // MARK: - Start Functionalities
    
    func start() {
        showScene()
        Theme.apply(theme: Theme.current())
    }
    
    func showScene() {
        // Create a scene with lisca file templates (cmd+n)
//        let coordinator = SceneCoordinator(dependencies: dependencies)
//        coordinator.delegate = self
//        switchTo(coordinator: coordinator)
    }
}
