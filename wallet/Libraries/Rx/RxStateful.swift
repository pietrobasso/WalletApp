//
//  RxStateful.swift
//  wallet
//
//  Created by Pietro Basso on 09/05/2018.
//  Copyright © 2018 Pietro Basso. All rights reserved.
//

// This protocol is inspired by reactor kit architecture.

import RxSwift

public protocol RxStateful: class {
    /// An action models a user action.
    associatedtype Action
    
    /// A mutation models a state change.
    associatedtype Mutation = Action
    
    /// A State represents the current state of a scene.
    associatedtype State
    
    /// The action from the view. Bind user inputs to this subject.
    var action: AnyObserver<Action> { get }
    
    /// The initial state.
    var initialState: State { get }
    
    /// The state observable stream.
    var state: Observable<State> { get }
    
    /// Transforms the action. Use this function to combine with other observables. This method is
    /// called once before the state stream is created.
    func transform(action: Observable<Action>) -> Observable<Action>
    
    /// Commits mutation from the action. This is the best place to perform side-effects such as
    /// async tasks through workers or services.
    func mutate(action: Action) -> Observable<Mutation>
    
    /// Transforms the mutation stream. Implement this method to transform or combine with other
    /// observables. This method is called once before the state stream is created.
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation>
    
    /// Generates a new state with the previous state and the action. It should be purely functional
    /// so it should not perform any side-effects here. This method is called every time when the
    /// mutation is committed.
    func reduce(state: State, mutation: Mutation) -> State
    
    /// Transforms the state stream. Use this function to perform side-effects such as logging. This
    /// method is called once after the state stream is created.
    func transform(state: Observable<State>) -> Observable<State>
}

private var actionKey = "action"
private var stateKey = "state"

// MARK: - Default Implementations
extension RxStateful {
    
    private var _action: PublishSubject<Action> {
        if let object: PublishSubject<Action> = objc_getAssociatedObject(self, &actionKey) as? PublishSubject<Action> {
            return object
        }
        let object = PublishSubject<Action>()
        objc_setAssociatedObject(self, &actionKey, object, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return object
    }
    
    public var action: AnyObserver<Action> {
        return _action.asObserver()
    }
    
    public var state: Observable<State> {
        if let object: Observable<State> = objc_getAssociatedObject(self, &stateKey) as? Observable<State> {
            return object
        }
        let object = createStateStream()
        objc_setAssociatedObject(self, &stateKey, object, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return object
    }
    
    /// Returns an Observable<State> which is tipically observed by the presenter.
    /// Remember that the stream is started only on subscription.
    /// Normally you don't need to override this method.
    public func createStateStream() -> Observable<State> {
        let action = _action.asObservable()
        let transformedAction = transform(action: action)
        let mutation = transformedAction
            .flatMap { [weak self] action -> Observable<Mutation> in
                guard let `self` = self else { return .empty() }
                return self.mutate(action: action).catchError { _ in .empty() }
        }
        let transformedMutation = transform(mutation: mutation)
        let state = transformedMutation
            .scan(initialState) { [weak self] state, mutation -> State in
                guard let `self` = self else { return state }
                return self.reduce(state: state, mutation: mutation)
            }
            .catchError { _ in .empty() }
            .startWith(initialState)
            .observeOn(MainScheduler.instance)
        let transformedState = transform(state: state)
        return transformedState.share(replay: 1, scope: .forever)
    }
    
    public func transform(action: Observable<Action>) -> Observable<Action> {
        return action
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        return mutation
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
    
    public func transform(state: Observable<State>) -> Observable<State> {
        return state
    }
}

extension RxStateful where Action == Mutation {
    public func mutate(action: Action) -> Observable<Mutation> {
        return .just(action)
    }
}
