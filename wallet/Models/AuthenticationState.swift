//
//  AuthenticationState.swift
//  wallet
//
//  Created by Pietro Basso on 20/02/2019.
//  Copyright © 2019 Pietro Basso. All rights reserved.
//

/// The available states of being logged in or not.
enum AuthenticationState: Equatable {
    case loggedIn, loggedOut
}

extension AuthenticationState {
    init(success: Bool) {
        self = success ? .loggedIn : .loggedOut
    }
}
