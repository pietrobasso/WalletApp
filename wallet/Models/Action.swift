//
//  Action.swift
//  wallet
//
//  Created by Pietro Basso on 20/02/2019.
//  Copyright © 2019 Pietro Basso. All rights reserved.
//

enum Action {
    case setPassword
    case removePassword
    case feedback
    case switchTheme
    case donate
}

extension Action {
    /**
     Descriptor is a dedicated type that can better describe a model to the UI, through an extension of the existing model.
     - Author: 152percent - [View Descriptors](https://152percent.com/blog/2018/4/16/view-descriptors)
     */
    struct Descriptor {
        
        private let action: Action
        
        init(action: Action) {
            self.action = action
        }
    }
    
    var descriptor: Descriptor {
        return Descriptor(action: self)
    }
}

extension Action.Descriptor {
    var title: String {
        switch action {
        case .setPassword:
            return "Set password"
        case .removePassword:
            return "Remove password"
        case .feedback:
            return "Feedback"
        case .donate:
            return "Donate to author"
        case .switchTheme:
            return "Night Mode"
        }
    }
    
    var buttonIsEnabled: Bool {
        switch action {
        case .switchTheme:
            return false
        default:
            return true
        }
    }
    
    var switchIsHidden: Bool {
        switch action {
        case .switchTheme:
            return false
        default:
            return true
        }
    }
    
    var switchIsOn: Bool {
        switch action {
        case .switchTheme:
            return Theme.current() == .dark
        default:
            return false
        }
    }
}
