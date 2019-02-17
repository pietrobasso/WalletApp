//
//  AppDependency.swift
//  lisca-iOS
//
//  Created by Pietro Basso on 14/02/2019.
//  Copyright © 2019 Rawfish. All rights reserved.
//

import Foundation

// The dependencies protocol defines what services it provides by adopting the services providers protocols
// i.e.: protocol AppDependencies: MyServiceProvider, MyManagerProvider { }
protocol AppDependencies: UserDefaultsServiceProvider, CardsManagerProvider { }

/// Defines all the dependenceis to be injected throughout the app.
class AppDependenciesProvider: AppDependencies {
    /// Holds the app dependencies singleton.
    static let provider = AppDependenciesProvider()
    
    // MARK: - Services
    let userDefaultsService: UserDefaultsService = {
        return StandardUserDefaultsService()
    }()

    // MARK: - Managers 
    // Managers can depend on services 
    lazy var cardsManager: CardsManager = {
        return MockedCardsManager(cardsCount: 25)
    }()
}
