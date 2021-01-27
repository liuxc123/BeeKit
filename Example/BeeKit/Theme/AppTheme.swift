//
//  Theme.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import BeeKit_Swift

// MARK: - 主题
public enum ThemeLevel: String {

    /// 主题色
    case primaryColor

    /// 辅助色
    case primaryColorVariant
    case secondaryColor
    case thirdColor

    /// 背景色
    case backgroundColor
    /// 背景色2
    case surfaceColor

    /// 字体颜色
    case onPrimaryColor
    case onSecondaryColor
    case onThirdColor
    case onPlaceholderColor

    /// 其他颜色
    case separatorColor
    case borderColor
    case whiteColor
}

public extension ThemeStyle {
    static let light = ThemeStyle(rawValue: "light")
    static let dark = ThemeStyle(rawValue: "dark")
}

public func UIColorTheme(_ level: ThemeLevel) -> ThemeProvider<UIColor> {
    return ThemeProvider({ AppThemeService.shared.themeColor(style: $0, level: level) })
}



