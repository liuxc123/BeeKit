//
//  Window.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit

open class Window: UIWindow {

    /// 自动切换夜间模式主题
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *), UITraitCollection.current.userInterfaceStyle == .dark {
            if ThemeManager.shared.currentThemeStyle != .dark {
                ThemeManager.shared.changeTheme(to: .dark)
            }
        } else {
            if ThemeManager.shared.currentThemeStyle != .light {
                ThemeManager.shared.changeTheme(to: .light)
            }
        }
    }
}

