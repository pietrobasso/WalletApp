//
//  Theme.swift
//  lisca
//
//  Created by Alessandro Maroso on 04/05/2017.
//  Copyright © 2017 Rawfish. All rights reserved.
//

import UIKit

///
/// Enum that describes all the possible styles of your app.
///
/// ## Setup
///
///     Theme.apply(theme: .default)
///
/// ## Example usage
///
///     view.backgroundColor = Theme.current().backgroundColor
///
public enum Theme: String {
    case `default` = "default"
    
    // MARK: - Colors
    
    var mainColor: UIColor {
        switch self {
        case .default:
            return UIColor.Wallet.black
        }
    }
    
    var secondaryColor: UIColor {
        switch self {
        case .default:
            return UIColor.Wallet.red
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .default:
            return UIColor.white
        }
    }
    
    // MARK: - Spacings
    
    var defaultViewPadding: Float {
        switch self {
        case .default:
            return 30
        }
    }
    
    var defaultSpacing: Float {
        switch self {
        case .default:
            return 15
        }
    }
    
    var bottomPadding: Float {
        switch self {
        case .default:
            return 4
        }
    }

    
    // MARK: - Navigation Bar
    
    var navBarStyle: UIBarStyle {
        switch self {
        case .default:
            return .default
        }
    }
    
    var navBackgroundColor: UIColor? {
        switch self {
        case .default:
            return nil
        }
    }
    
    var navBarTranslucent: Bool {
        switch self {
        case .default:
            return true
        }
    }
    
    var navBackgroundImage: UIImage? {
        switch self {
        case .default:
            return nil
        }
    }
    
    var navShadowImage: UIImage? {
        switch self {
        case .default:
            return UIImage()
        }
    }
    
    var navBackIndicatorImage: UIImage? {
        switch self {
        case .default:
            return nil
        }
    }
    
    var navBackIndicatorMask: UIImage? {
        switch self {
        case .default:
            return nil
        }
    }
    
    // MARK: - UIButton
    
    var buttonHeight: CGFloat {
        switch self {
        case .default:
            return 40
        }
    }
    
    var buttonCornerRadius: CGFloat {
        switch self {
        case .default:
            return 20
        }
    }
}

public extension Theme {
    static let selectedThemeKey = "selectedThemeKey"
    
    static func current() -> Theme {
        if let storedThemeName = UserDefaults.standard.value(forKey: selectedThemeKey) as? String, let storedTheme = Theme(rawValue: storedThemeName) {
            return storedTheme
        } else {
            return .default
        }
    }
    
    public static func apply(theme: Theme) {
        UserDefaults.standard.set(theme.rawValue, forKey: selectedThemeKey)
        
        UIApplication.shared.delegate?.window??.tintColor = theme.secondaryColor
        UIApplication.shared.delegate?.window??.backgroundColor = theme.backgroundColor
        customizeNavBars(with: theme)
        customizeTableViews(with: theme)
        customizeTableViewCells(with: theme)
        customizeTabBars(with: theme)
        customizeTabBarItems(with: theme)
        customizeToolbars(with: theme)
        customizeBarItems(with: theme)
        customizeBarButtonItems(with: theme)
        customizeButtons(with: theme)
        customizePageControls(with: theme)
        customizeProgressViews(with: theme)
        customizeSearchBars(with: theme)
        customizeActivityIndicators(with: theme)
        customizeSegmentedControls(with: theme)
        customizeSteppers(with: theme)
        customizeSliders(with: theme)
        customizeSwitches(with: theme)
        customizeAlerts(with: theme)
        customizeRefreshControls(with: theme)
        customizeProgress(with: theme)
        customizeViews(with: theme)
    }
    
    // See https://gist.github.com/mattt/5135521 for a list of properties conforming to UIAppearance
    
    private static func customizeNavBars(with theme:Theme) {
        UINavigationBar.appearance().barStyle = theme.navBarStyle
        UINavigationBar.appearance().tintColor = theme.secondaryColor
        UINavigationBar.appearance().barTintColor = theme.navBackgroundColor
        UINavigationBar.appearance().isTranslucent = theme.navBarTranslucent
        theme.navBackgroundImage.map { UINavigationBar.appearance().setBackgroundImage($0, for: .default) }
        UINavigationBar.appearance().backIndicatorImage = theme.navBackIndicatorImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = theme.navBackIndicatorMask
        UINavigationBar.appearance().titleTextAttributes = [
            // NSFontAttributeName: UIFont.LatoBoldFont(size: 18),
            NSAttributedString.Key.foregroundColor: theme.mainColor
        ]
        UINavigationBar.appearance().shadowImage = theme.navShadowImage
    }
    
    private static func customizeTableViews(with theme:Theme) {
    }
    
    private static func customizeTableViewCells(with theme:Theme) {
    }
    
    private static func customizeTabBars(with theme:Theme) {
    }
    
    private static func customizeTabBarItems(with theme:Theme) {
    }
    
    private static func customizeToolbars(with theme:Theme) {
    }
    
    private static func customizeBarItems(with theme:Theme) {
    }
    
    private static func customizeBarButtonItems(with theme:Theme) {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes([.foregroundColor: theme.secondaryColor], for: .normal)
    }
    
    private static func customizeButtons(with theme:Theme) {
    }
    
    private static func customizePageControls(with theme:Theme) {
        UIPageControl.appearance().currentPageIndicatorTintColor = theme.mainColor
        UIPageControl.appearance().pageIndicatorTintColor = theme.mainColor.withAlphaComponent(0.5)
    }
    
    private static func customizeProgressViews(with theme:Theme) {
    }
    
    private static func customizeSearchBars(with theme:Theme) {
    }
    
    private static func customizeActivityIndicators(with theme:Theme) {
    }
    
    private static func customizeSegmentedControls(with theme:Theme) {
    }
    
    private static func customizeSteppers(with theme:Theme) {
    }
    
    private static func customizeSliders(with theme:Theme) {
    }
    
    private static func customizeSwitches(with theme:Theme) {
    }
    
    private static func customizeAlerts(with theme:Theme) {
    }
    
    private static func customizeRefreshControls(with theme:Theme) {
    }
    
    private static func customizeProgress(with theme:Theme) {
    }
    
    private static func customizeViews(with theme:Theme) {
    }
}

