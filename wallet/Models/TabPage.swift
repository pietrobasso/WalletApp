//
//  TabPage.swift
//  wallet
//
//  Created by Pietro Basso on 14/02/2019.
//  Copyright © 2019 Pietro Basso. All rights reserved.
//

import UIKit

enum TabPage {
    case cards
    case offers
    case settings
}

extension TabPage {
    /**
     Descriptor is a dedicated type that can better describe a model to the UI, through an extension of the existing model.
     - Author: 152percent - [View Descriptors](https://152percent.com/blog/2018/4/16/view-descriptors)
     */
    struct Descriptor {
        
        private let tabPage: TabPage
        
        init(tabPage: TabPage) {
            self.tabPage = tabPage
        }
    }
    
    var descriptor: Descriptor {
        return Descriptor(tabPage: self)
    }
}

extension TabPage.Descriptor {
    var image: UIImage? {
        switch tabPage {
        case .cards:
            return #imageLiteral(resourceName: "icon-card").withRenderingMode(.alwaysTemplate)
        case .offers:
            return #imageLiteral(resourceName: "icon-card").withRenderingMode(.alwaysTemplate)
        case .settings:
            return #imageLiteral(resourceName: "icon-card").withRenderingMode(.alwaysTemplate)
        }
    }
    
    var selectedImage: UIImage? {
        return image
    }
}
