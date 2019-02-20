//
//  ActionCell.swift
//  wallet
//
//  Created by Pietro Basso on 20/02/2019.
//  Copyright © 2019 Pietro Basso. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ActionCell: UITableViewCell, Reusable {
    
    // MARK: - Views
    fileprivate lazy var titleButton: UIButton = {
        let button = HighlightedButton()
        button.backgroundColor = Theme.current().backgroundColor
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAppearance()
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func configure(with descriptor: Action.Descriptor) {
        titleButton.setAttributedTitle(NSAttributedString(string: descriptor.title,
                                                          attributes: [.foregroundColor: Theme.current().secondaryColor,
                                                                       .font: UIFont.systemFont(ofSize: 22, weight: .regular)]),
                                       for: .normal)
    }
    
    private func setupAppearance() {
        selectionStyle = .none
        backgroundColor = Theme.current().backgroundColor
    }
    
    private func addSubviews() {
        addSubview(titleButton)
        titleButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}

extension Reactive where Base: ActionCell {
    var tap: ControlEvent<Void> {
        return base.titleButton.rx.tap
    }
    
    var viewModel: Binder<Action.Descriptor> {
        return Binder(base) { (cell, descriptor) in
            cell.configure(with: descriptor)
        }
    }
}
