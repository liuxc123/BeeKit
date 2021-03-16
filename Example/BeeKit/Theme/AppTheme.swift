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

    /// 灰色
    case grayColor
    case grayColor2
    case grayColor3
    case grayColor4
    case grayColor5
    case grayColor6

    /// 主题色
    case primaryColor
    case secondaryColor
    case thirdColor
    case forthColor

    /// 字体颜色
    case onPrimaryColor
    case onSecondaryColor
    case onThirdColor
    case onForthColor

    /// 链接
    case linkColor

    /// 占位符字体颜色
    case placeholderTextColor

    /// 分割线颜色
    case separatorColor
    case opaqueSeparatorColor

    /// 边框颜色
    case borderColor

    /// 背景色
    case backgroundColor
    case secondaryBackgroundColor
    case thirdBackgroundColor

    /// 填充颜色
    case fillColor
    case secondaryFillColor
    case thirdFillColor
    case fouthFillColor

    /// 分组颜色
    case groupedBackgroundColor
    case secondaryGroupedBackgroundColor
    case thirdGroupedBackgroundColor

    /// 文本颜色
    case lightTextColor
    case darkTextColor
}

public extension ThemeStyle {
    static let light = ThemeStyle(rawValue: "light")
    static let dark = ThemeStyle(rawValue: "dark")
}

public func UIColorTheme(_ level: ThemeLevel) -> ThemeProvider<UIColor> {
    return ThemeProvider({ AppThemeService.shared.themeColor(style: $0, level: level) })
}

public func UIColorTheme(_ style: ThemeStyle, level: ThemeLevel) -> UIColor {
    return AppThemeService.shared.themeColor(style: style, level: level)
}
