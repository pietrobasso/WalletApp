//
//  UIButton+Toggle.swift
//  lisca
//
//  Created by Pietro Basso on 07/08/2017.
//  Copyright © 2017 Rawfish. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit
    
extension Reactive where Base: UIButton {
    public var toggle: Binder<Void> {
        return Binder(base) { button, _ in
            button.isSelected = !button.isSelected
        }
    }
}
