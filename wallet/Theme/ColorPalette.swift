//
//  ColorPalette.swift
//  wallet
//
//  Created by Pietro Basso on 14/02/2019.
//  Copyright © 2019 Pietro Basso. All rights reserved.
//

import UIKit

extension UIColor {
    /// Color palette inspired from [Apple Developer Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/).
    ///
    /// Additional colors inspired from [iOS 7 colors](http://ios7colors.zenimot.com).
    ///
    enum Wallet: CaseIterable, Equatable, Hashable {
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

extension UIColor.Wallet {
    var fillColor: UIColor {
        switch self {
        case .red:
            return UIColor(netHex: 0xFF3B30)
        case .radicalRed:
            return UIColor(netHex: 0xFB2B69)
        case .orange:
            return UIColor(netHex: 0xFF9500)
        case .yellow:
            return UIColor(netHex: 0xFFCC00)
        case .green:
            return UIColor(netHex: 0x4CD964)
        case .tealBlue:
            return UIColor(netHex: 0x5AC8FA)
        case .blue:
            return UIColor(netHex: 0x007AFF)
        case .purple:
            return UIColor(netHex: 0x5856D6)
        case .pink:
            return UIColor(netHex: 0xFF2D55)
        case .black:
            return UIColor(netHex: 0x2B2B2B)
        case .gray:
            return UIColor(netHex: 0x898C90)
        }
    }
    
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

extension UIColor.Wallet {
    static var brightColors: [UIColor.Wallet] {
        return [.red, .radicalRed, .orange, .green, .purple, .pink]
    }
}
