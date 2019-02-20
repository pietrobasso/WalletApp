//
//  Section.swift
//  wallet
//
//  Created by Pietro Basso on 20/02/2019.
//  Copyright © 2019 Pietro Basso. All rights reserved.
//

import UIKit

struct Section<Element> {
    let title: String
    let dataSource: [Element]
}

extension Section {
    /**
     Descriptor is a dedicated type that can better describe a model to the UI, through an extension of the existing model.
     - Author: 152percent - [View Descriptors](https://152percent.com/blog/2018/4/16/view-descriptors)
     */
    struct Descriptor {
        
        private let section: Section
        
        init(section: Section) {
            self.section = section
        }
    }
    
    var descriptor: Descriptor {
        return Descriptor(section: self)
    }
}

extension Section.Descriptor {
    var headerView: UIView {
        let view: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let label: UIView = {
            let button = UIButton()
            button.setTitle(section.title, for: .normal)
            button.setTitleColor(UIColor.Wallet.black.fillColor, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
            button.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            button.setContentHuggingPriority(.defaultLow, for: .horizontal)
            button.isUserInteractionEnabled = false
            button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        view.addSubview(label)
        label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        return view
    }
}
