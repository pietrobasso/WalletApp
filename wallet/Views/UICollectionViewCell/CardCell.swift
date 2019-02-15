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

struct CardCellViewModel: Equatable, Hashable {
    let title: String
    let description: String
    let badgeNumber: Int
    let color: UIColor.Wallet
}

extension CardCellViewModel {
    static var random: CardCellViewModel {
        let title = ["Pam", "Despar", "IKEA", "MediaMarkt", "Accessorize", "Zara", "H&M", "Hofer", "Lidl"].randomElement() ?? "Zara"
        let description = [String(Int.random(in: 0...200)), "Points"].joined(separator: " ")
        let badgeNumber = Int.random(in: 0...1)
        let color = UIColor.Wallet.brightColors.randomElement() ?? .red
        return CardCellViewModel(title: title, description: description, badgeNumber: badgeNumber, color: color)
    }
}

class CardCell: UICollectionViewCell, Reusable {
    
    // MARK: - Variables
    private let badgeHeight: CGFloat = 24
    private lazy var badgeInset: CGFloat = {
        return badgeHeight / 2 - 7
    }()
    
    // MARK: - Views
    fileprivate lazy var button: ShrinkableGradientButton = {
        let button = ShrinkableGradientButton()
        button.layer.cornerRadius = Theme.current().buttonCornerRadius
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
        button.backgroundColor = UIColor.Wallet.red.fillColor
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
    
    func configure(with viewModel: CardCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        button.backgroundColor = viewModel.color.fillColor
        button.gradientLayer = CAGradientLayer(frame: button.frame,
                                               colors: viewModel.color.gradientColors,
                                               startPoint: CGPoint(x: 0, y: 0),
                                               endPoint: CGPoint(x: 1, y: 1))
        setupBadge(viewModel.badgeNumber)
    }
    
    private func setupAppearance() {
        
    }
    
    private func addSubviews() {
        addSubview(button)
        button.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        
        button.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2).isActive = true
        
        button.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2).isActive = true
        
        titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor).isActive = true
        
        addSubview(badgeView)
        badgeView.topAnchor.constraint(equalTo: button.topAnchor, constant: -badgeInset).isActive = true
        badgeView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: badgeInset).isActive = true
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
        return base.button.rx.tap
    }
    
    var viewModel: Binder<CardCellViewModel> {
        return Binder(base) { (cell, viewModel) in
            cell.configure(with: viewModel)
        }
    }
}
