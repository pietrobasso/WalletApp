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
    
    let initialState = UserState(actions: [.setPassword, .feedback])
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
            switch indexPath.row {
            case 0:
                switch dependencies.userDefaultsService.hasValue(for: .loggedIn) {
                case true:
                    dependencies.userDefaultsService.removeValue(for: .loggedIn)
                    return .just(.passwordRemoved)
                case false:
                    return (dependencies.localAuthenticationService as? LocalAuthenticationServiceImplementation)?.rx.authenticate()
                        .asObservable()
                        .flatMap { [weak self] (result) -> Observable<Mutation> in
                            guard case let .success(success) = result, success else { return .empty() }
                            self?.dependencies.userDefaultsService.set(value: true, for: .loggedIn)
                            return .just(.passwordAdded)
                        } ?? .empty()
                }
            case 1:
                if let url = URL(string: "mailto:hello@pietrobasso.it") {
                    delegate?.open(url: url)
                }
                return .empty()
            default:
                return .empty()
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> UserState {
        switch mutation {
        case .passwordRemoved:
            return State(actions: [.setPassword, .feedback])
        case .passwordAdded:
            return State(actions: [.removePassword, .feedback])
        }
    }
}