//
//  Theme.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import BeeKit

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

extension ThemeStyle {
    static let light = ThemeStyle(rawValue: "light")
    static let dark = ThemeStyle(rawValue: "dark")
}

class AppThemeService {
    static let shared = AppThemeService()
    let configs: [String: [String: String]]

    init() {
        let plistPath = Bundle.main.path(forResource: "AppTheme", ofType: "plist")
        if plistPath == nil {
            configs = [String: [String: String]]()
        }else {
            let sources = NSDictionary(contentsOfFile: plistPath!) as? [String: [String: String]]
            if sources == nil {
                configs = [String: [String: String]]()
            }else {
                configs = sources!
            }
        }
    }

    func themeColor(style: ThemeStyle, level: ThemeLevel) -> UIColor {
        if let hex = configs[style.rawValue]?[level.rawValue] {
            return UIColor(hexString: hex) ?? .clear
        }else {
            //可以根据需求配置默认色
            return UIColor.gray
        }
    }
}

func UIColorMake(_ level: ThemeLevel) -> ThemeProvider<UIColor> {
    return ThemeProvider({ AppThemeService.shared.themeColor(style: $0, level: level) })
}

func UIFontMake(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: <#T##CGFloat#>)
}
