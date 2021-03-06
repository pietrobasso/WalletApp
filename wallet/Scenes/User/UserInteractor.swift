//
//  UserInteractor.swift
//  wallet
//
//  Created by Pietro Basso on 20/02/2019.
//  Copyright (c) 2019 Pietro Basso. All rights reserved.
//
//  This file was generated by the Lisca Xcode Templates so
//  you can apply lisca architecture to your iOS projects
//

import UIKit
import RxSwift
import RxCocoa

protocol UserInteractorDelegate: class {
    func open(url: URL)
    func switchTheme()
}

struct UserState {
    var actions: [Action]
}

class UserInteractor: UserViewControllerOutput, UserPresenterInput, RxStateful {
    
    typealias Action = UserAction
    typealias State = UserState
    typealias Dependencies = LocalAuthenticationServiceProvider & UserDefaultsServiceProvider
    
    enum Mutation {
        case passwordAdded
        case passwordRemoved
    }
    
    let initialState = UserState(actions: [.setPassword, .feedback, .switchTheme])
    let dependencies: Dependencies
    
    weak var delegate: UserInteractorDelegate?
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewLoaded:
            if dependencies.userDefaultsService.hasValue(for: .loggedIn) {
                return .just(.passwordAdded)
            }
            return .empty()
        case .didTapCellAt(let indexPath):
            return state
                .map { $0.actions[safe: indexPath.row] }
                .take(1)
                .flatMap { [weak self] (action) -> Observable<Mutation> in
                    guard let action = action else { return .empty() }
                    switch action {
                    case .setPassword:
                        return (self?.dependencies.localAuthenticationService as? LocalAuthenticationServiceImplementation)?.rx.authenticate()
                            .asObservable()
                            .flatMap { [weak self] (result) -> Observable<Mutation> in
                                guard case let .success(success) = result, success else { return .empty() }
                                self?.dependencies.userDefaultsService.set(value: true, for: .loggedIn)
                                return .just(.passwordAdded)
                            } ?? .empty()
                    case .removePassword:
                        self?.dependencies.userDefaultsService.removeValue(for: .loggedIn)
                        return .just(.passwordRemoved)
                    case .feedback:
                        if let url = URL(string: "mailto:hello@pietrobasso.it") {
                            self?.delegate?.open(url: url)
                        }
                        return .empty()
                    case .switchTheme:
                        self?.delegate?.switchTheme()
                        return .empty()
                    case .donate:
                        return .empty()
                    }
                }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> UserState {
        var copy = state
        switch mutation {
        case .passwordRemoved:
            copy.actions.removeFirst()
            copy.actions.insert(.setPassword, at: 0)
            return copy
        case .passwordAdded:
            copy.actions.removeFirst()
            copy.actions.insert(.removePassword, at: 0)
            return copy
        }
    }
}
