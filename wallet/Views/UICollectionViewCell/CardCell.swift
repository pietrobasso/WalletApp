//
//  CardCell.swift
//  wallet
//
//  Created by Pietro Basso on 15/02/2019.
//  Copyright © 2019 Pietro Basso. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CardCell: UICollectionViewCell, Reusable {
    
    // MARK: - Variables
    private let badgeHeight: CGFloat = 24
    private lazy var badgeInset: CGFloat = {
        return badgeHeight / 2 - 7
    }()
    
    // MARK: - Views
    fileprivate lazy var buttonContainer: ShrinkableButton = {
        let button = ShrinkableButton()
        button.backgroundColor = .clear
        button.clipsToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var button: GradientButton = {
        let button = GradientButton()
        button.layer.cornerRadius = Theme.current().buttonCornerRadius
        button.isUserInteractionEnabled = false
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.heavy)
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var badgeView: UIButton = {
        let button = UIButton()
        button.contentEdgeInsets = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        button.backgroundColor = Theme.current().secondaryColor
        button.clipsToBounds = true
        button.layer.cornerRadius = badgeHeight / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func configure(with descriptor: Card.Descriptor) {
        titleLabel.text = descriptor.title
        descriptionLabel.text = descriptor.description
        button.gradientLayer = CAGradientLayer(frame: buttonContainer.frame,
                                               colors: descriptor.color.gradientColors,
                                               startPoint: CGPoint(x: 0, y: 0),
                                               endPoint: CGPoint(x: 1, y: 1))
        setupBadge(descriptor.badgeCount)
    }
    
    private func setupAppearance() {
        
    }
    
    private func addSubviews() {
        addSubview(buttonContainer)
        buttonContainer.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        buttonContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        buttonContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        buttonContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        
        buttonContainer.addSubview(button)
        button.topAnchor.constraint(equalTo: buttonContainer.topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor).isActive = true
        
        button.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: button.topAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 2).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -2).isActive = true
        
        button.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 2).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -5).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -2).isActive = true
        
        titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor).isActive = true
        
        buttonContainer.addSubview(badgeView)
        badgeView.topAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: -badgeInset).isActive = true
        badgeView.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor, constant: badgeInset).isActive = true
        badgeView.heightAnchor.constraint(equalToConstant: badgeHeight).isActive = true
        badgeView.widthAnchor.constraint(greaterThanOrEqualToConstant: badgeHeight).isActive = true
    }
    
    private func setupBadge(_ badgeNumber: Int) {
        badgeView.isHidden = badgeNumber == 0
        badgeView.setAttributedTitle(NSAttributedString(string: String(badgeNumber),
                                                        attributes: [.foregroundColor: UIColor.white,
                                                                     .font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)]),
                                     for: .normal)
    }
}

extension Reactive where Base: CardCell {
    var tap: ControlEvent<Void> {
        return base.buttonContainer.rx.tap
    }
    
    var viewModel: Binder<Card.Descriptor> {
        return Binder(base) { (cell, descriptor) in
            cell.configure(with: descriptor)
        }
    }
}
