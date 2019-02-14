//
//  PageCoordinator.swift
//  lisca-iOS
//
//  Created by Pietro Basso on 14/02/2019.
//  Copyright © 2019 Rawfish. All rights reserved.
//

import UIKit

protocol PageProvider {
    var pageController: UIPageViewController { get }
    func addPage(coordinator: Coordinator)
    func removePage(coordinator: Coordinator)
}

typealias PageCoordinator = Coordinator & PageProvider & UIPageViewControllerDataSource
