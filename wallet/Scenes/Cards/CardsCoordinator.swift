//
//  CardsCoordinator.swift
//  wallet
//
//  Created by Pietro Basso on 14/02/2019.
//  Copyright (c) 2019 Pietro Basso. All rights reserved.
//
//  This file was generated by the Lisca Xcode Templates so
//  you can apply lisca architecture to your iOS projects
//

import UIKit

class CardsCoordinator: NavigationCoordinator {
    var childrenCoordinators: [Coordinator] = []
    let viewController: UIViewController
    let navigationController: UINavigationController

    weak var delegate: CoordinatorDelegate?
    private let navigationControllerDelegate = CustomNavigationControllerDelegate { (navigationController, viewController, animated) in
        navigationController.navigationBar.prefersLargeTitles = true
    }
    
    init(dependencies: AppDependencies, navigationController: UINavigationController? = nil) {
        let interactor = CardsInteractor(dependencies: dependencies)
        let presenter = CardsPresenter(input: interactor)
        let viewController = CardsViewController(input: presenter, output: interactor)
        if let navigationController = navigationController {
            self.viewController = viewController
            self.navigationController = navigationController
        } else {
            self.navigationController = UINavigationController(rootViewController: viewController)
            self.viewController = self.navigationController
        }
        interactor.delegate = self
        self.navigationController.delegate = navigationControllerDelegate
    }
    
    func start() { }

    private func pushChildScene() {
//        let coordinator = ChildCoordinator(dependencies: dependencies, navigationController: navigationController)
//        coordinator.delegate = self
//        coordinator.start()
//        push(child: coordinator)
    }    
}

// MARK: - Extension: CardsInteractorDelegate
extension CardsCoordinator: CardsInteractorDelegate {
    func dismissAction() {
        delegate?.dismiss(coordinator: self)
    }
}
