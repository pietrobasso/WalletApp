//
//  OnboardingPresenter.swift
//  wallet
//
//  Created by Pietro Basso on 14/02/2019.
//  Copyright (c) 2019 Pietro Basso. All rights reserved.
//
//  This file was generated by the Lisca Xcode Templates so
//  you can apply lisca architecture to your iOS projects
//

import UIKit
import RxSwift
import RxCocoa

protocol OnboardingPresenterInput {
    var state: Observable<OnboardingState> { get }
}

class OnboardingPresenter: OnboardingViewControllerInput {
    
    // MARK: OnboardingViewControllerInput
    let title: Driver<String>
    let mainImage: Driver<UIImage?>
    let description: Driver<String>
    let buttonTitle: Driver<String>
    
    init(input: OnboardingPresenterInput) {
        title = input.state
            .map { state -> String in "What's New in Wallet" }
            .asDriver(onErrorJustReturn: "")
        mainImage = input.state
            .map { _ in #imageLiteral(resourceName: "icon-app").withRenderingMode(.alwaysOriginal) }
            .asDriver(onErrorJustReturn: nil)
        description = input.state
            .map { _ in ["Welcome!", "This is an example of what you can achieve using VIP and Coordinator architectural patterns, together with a little", "🕊 RxSwift magic ✨", "Enjoy!"].joined(separator: "\n") }
            .asDriver(onErrorJustReturn: "")
        buttonTitle = input.state
            .map { _ in "Continue" }
            .asDriver(onErrorJustReturn: "")
    }
}
