//
//  UserDefaultsService.swift
//  Pcup
//
//  Created by Ciprian Cojan on 20/07/2018.
//  Copyright © 2018 Rawfish. All rights reserved.
//

import Foundation

protocol UserDefaultsService {
    func value<T>(for key: UserDefaultsKey) -> T?
    func set<T>(value:T, for key: UserDefaultsKey)
    func hasValue(for key:UserDefaultsKey) -> Bool
    func removeValue(for key:UserDefaultsKey)
}

protocol UserDefaultsServiceProvider {
    var userDefaultsService: UserDefaultsService { get }
}

/// Update this enum with new required keys
public enum UserDefaultsKey: String {
    case onboardingCompleted
    case loggedIn
}

final class StandardUserDefaultsService: UserDefaultsService {
    func value<T>(for key: UserDefaultsKey) -> T? {
        return UserDefaults.standard.object(forKey: key.rawValue) as? T ?? nil
    }
    
    func set<T>(value:T, for key: UserDefaultsKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func hasValue(for key:UserDefaultsKey) -> Bool {
        return UserDefaults.standard.object(forKey: key.rawValue) != nil
    }
    
    func removeValue(for key:UserDefaultsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
