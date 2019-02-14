//
//  ColorPalette.swift
//  wallet
//
//  Created by Pietro Basso on 14/02/2019.
//  Copyright © 2019 Pietro Basso. All rights reserved.
//

import UIKit

extension UIColor {
    struct Wallet {
        // Color palette inspired from Apple Developer Human Interface Guidelines https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/
        static let red = UIColor(netHex: 0xFF3B30)
        static let orange = UIColor(netHex: 0xFF9500)
        static let yellow = UIColor(netHex: 0xFFCC00)
        static let green = UIColor(netHex: 0x4CD964)
        static let tealBlue = UIColor(netHex: 0x5AC8FA)
        static let blue = UIColor(netHex: 0x007AFF)
        static let purple = UIColor(netHex: 0x5856D6)
        static let pink = UIColor(netHex: 0xFF2D55)
        // Additional colors inspired from iOS 7 colors http://ios7colors.zenimot.com
        static let radicalRed = UIColor(netHex: 0xFB2B69)
        static let black = UIColor(netHex: 0x2B2B2B)
        static let gray = UIColor(netHex: 0x898C90)
    }
}

extension CAGradientLayer {
    struct Wallet {
        enum Color: CaseIterable {
            case red
            case radicalRed
            case orange
            case yellow
            case green
            case tealBlue
            case blue
            case purple
            case pink
            case black
            case gray
        }
    }
    
    convenience init(frame: CGRect, color: Wallet.Color, startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0), endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0), locations: [NSNumber]? = nil) {
        self.init()
        self.frame = frame
        self.colors = color.gradientColors
        self.locations = locations
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
}

extension CAGradientLayer.Wallet.Color {
    var gradientColors: [CGColor] {
        switch self {
        case .red:
            return [UIColor(netHex: 0xFF5E3A), UIColor(netHex: 0xFF2A68)].map { $0.cgColor }
        case .radicalRed:
            return [UIColor(netHex: 0xFB2B69), UIColor(netHex: 0xFF5B37)].map { $0.cgColor }
        case .orange:
            return [UIColor(netHex: 0xFF9500), UIColor(netHex: 0xFF5E3A)].map { $0.cgColor }
        case .yellow:
            return [UIColor(netHex: 0xFFDB4C), UIColor(netHex: 0xFFCD02)].map { $0.cgColor }
        case .green:
            return [UIColor(netHex: 0x87FC70), UIColor(netHex: 0x0BD318)].map { $0.cgColor }
        case .tealBlue:
            return [UIColor(netHex: 0x52EDC7), UIColor(netHex: 0x5AC8FB)].map { $0.cgColor }
        case .blue:
            return [UIColor(netHex: 0x1AD6FD), UIColor(netHex: 0x1D62F0)].map { $0.cgColor }
        case .purple:
            return [UIColor(netHex: 0xC644FC), UIColor(netHex: 0x5856D6)].map { $0.cgColor }
        case .pink:
            return [UIColor(netHex: 0xEF4DB6), UIColor(netHex: 0xC643FC)].map { $0.cgColor }
        case .black:
            return [UIColor(netHex: 0x4A4A4A), UIColor(netHex: 0x2B2B2B)].map { $0.cgColor }
        case .gray:
            return [UIColor(netHex: 0xDBDDDE), UIColor(netHex: 0x898C90)].map { $0.cgColor }
        }
    }
}
