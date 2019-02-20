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
        }
    }
}
