//
//  CardViewController.swift
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

protocol CardViewControllerInput {
    var animateCard: Driver<Bool> { get }
    var title: Driver<String> { get }
    var mainEmoji: Driver<String> { get }
    var description: Driver<String> { get }
    var mainButtonTitle: Driver<String> { get }
}

protocol CardViewControllerOutput {
    var action: AnyObserver<CardAction> { get }
}

enum CardAction {
    case viewLoaded
    case viewAppeared
    case dismissButtonTapped
    case presentingCompleted
}

class CardViewController: UIViewController {
    
    let input: CardViewControllerInput
    let output: CardViewControllerOutput
    private let disposeBag = DisposeBag()
    
    // MARK: - Views
    private lazy var snapshotView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var backgroundOverlayButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var cardBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.current().backgroundColor
        view.clipsToBounds = true
        view.layer.cornerRadius = Theme.current().buttonCornerRadius
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 80, weight: UIFont.Weight.black)
        label.textColor = Theme.current().mainColor
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
        label.textColor = Theme.current().mainColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var dismissButton: UIButton = {
        let button = HighlightedButton()
        button.backgroundColor = Theme.current().secondaryColor
        button.titleLabel?.textColor = Theme.current().backgroundColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        button.layer.cornerRadius = Theme.current().buttonCornerRadius
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var snapshotWidthConstraint: NSLayoutConstraint?
    private var snapshotHeightConstraint: NSLayoutConstraint?
    private var cardBackgroundBottomConstraint: NSLayoutConstraint?
    private var statusBarStyle = Theme.current().statusBarStyle
    private let cardHeight: CGFloat = 0.92
    
    // MARK: - Lifecycle
    
    init(input: CardViewControllerInput, output: CardViewControllerOutput) {
        self.input = input
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        addSubviews()
        setupBindings()
        output.action.onNext(.viewLoaded)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.action.onNext(.viewAppeared)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }

    private func setupAppearance() { }
    
    private func addSubviews() {
        view.addSubview(backgroundOverlayButton)
        backgroundOverlayButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundOverlayButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundOverlayButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundOverlayButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(cardBackgroundView)
        cardBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cardBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cardBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardBackgroundView.heightAnchor.constraint(equalToConstant: view.frame.size.height * cardHeight).isActive = true
        cardBackgroundBottomConstraint = cardBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.size.height * cardHeight)
        cardBackgroundBottomConstraint?.isActive = true
        
        cardBackgroundView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: cardBackgroundView.topAnchor, constant: 100).isActive = true
        stackView.leadingAnchor.constraint(equalTo: cardBackgroundView.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: cardBackgroundView.trailingAnchor, constant: -20).isActive = true
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        cardBackgroundView.addSubview(dismissButton)
        dismissButton.leadingAnchor.constraint(equalTo: cardBackgroundView.leadingAnchor, constant: 20).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: cardBackgroundView.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: cardBackgroundView.trailingAnchor, constant: -20).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: Theme.current().buttonHeight).isActive = true
        
        stackView.bottomAnchor.constraint(equalTo: dismissButton.topAnchor, constant: -30).isActive = true
    }
    
    private func setupBindings() {
        input.title.asObservable()
            .bind(to: rx.title)
            .disposed(by: disposeBag)
        input.animateCard.asObservable()
            .take(1)
            .do(onNext: { [weak self] _ in
                self?.addSnapshotView()
            })
            .bind(to: rx.animateCard)
            .disposed(by: disposeBag)
        input.animateCard.asObservable()
            .skip(1)
            .bind(to: rx.animateCard)
            .disposed(by: disposeBag)
        input.title.asObservable()
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        input.description.asObservable()
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        input.mainButtonTitle.asObservable()
            .bind(to: dismissButton.rx.title())
            .disposed(by: disposeBag)
        dismissButton.rx.tap
            .asSignal()
            .throttle(0.2, latest: false)
            .emit(onNext: { [weak self] _ in
                self?.output.action.onNext(.dismissButtonTapped)
            })
            .disposed(by: disposeBag)
        backgroundOverlayButton.rx.tap
            .asSignal()
            .throttle(0.2, latest: false)
            .emit(onNext: { [weak self] _ in
                self?.output.action.onNext(.dismissButtonTapped)
            })
            .disposed(by: disposeBag)
    }
    
    private func addSnapshotView() {
        snapshotView = {
            guard let view = presentingViewController?.view.snapshotView(afterScreenUpdates: true) else { return snapshotView }
            view.clipsToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        view.insertSubview(snapshotView, at: 0)
        view.backgroundColor = .black
        snapshotWidthConstraint = snapshotView.widthAnchor.constraint(equalTo: view.widthAnchor)
        snapshotHeightConstraint = snapshotView.heightAnchor.constraint(equalTo: view.heightAnchor)
        snapshotView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        snapshotView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        snapshotWidthConstraint?.isActive = true
        snapshotHeightConstraint?.isActive = true
    }
    
    private func configureSnapshot(presenting: Bool) {
        let aspectRatio = (snapshotView.frame.size.height / snapshotView.frame.size.width)
        snapshotHeightConstraint?.constant = presenting ? aspectRatio * -35 : 0
        snapshotWidthConstraint?.constant = presenting ? -35 : 0
        statusBarStyle = presenting ? .lightContent : Theme.current().statusBarStyle
    }
    
    fileprivate func animateSnapshot(presenting: Bool) {
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.backgroundOverlayButton.alpha = presenting ? 0.3 : 0
        }
        UIView.animate(withDuration: presenting ? 0.3 : 0.6,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: presenting ? .curveEaseOut : .curveEaseIn,
                       animations: { [weak self] in
                        self?.snapshotView.layer.cornerRadius = presenting ? Theme.current().buttonCornerRadius : 0
            }, completion: nil)
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: presenting ? .curveEaseOut : .curveEaseIn,
                       animations: { [weak self] in
                        self?.configureSnapshot(presenting: presenting)
                        self?.setNeedsStatusBarAppearanceUpdate()
                        self?.view.layoutIfNeeded()
        }) { [weak self] (finished) in
            if !presenting {
                self?.output.action.onNext(.presentingCompleted)
            }
        }
    }
    
    fileprivate func animateCardBackground(presenting: Bool) {
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: presenting ? .curveEaseOut : .curveEaseIn,
                       animations: { [weak self] in
                        guard let height = self?.view.frame.size.height, let cardHeight = self?.cardHeight else { return }
                        self?.cardBackgroundBottomConstraint?.constant = presenting ? 0 : height * cardHeight
                        self?.view.layoutIfNeeded()
            }, completion: nil)
    }
}

extension Reactive where Base: CardViewController {
    var animateCard: Binder<Bool> {
        return Binder(base) { (viewController, presenting) in
            viewController.animateSnapshot(presenting: presenting)
            viewController.animateCardBackground(presenting: presenting)
        }
    }
}
