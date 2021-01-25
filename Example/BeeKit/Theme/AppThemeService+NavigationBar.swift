//
//  AppTheme+NavigationBar.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BEEPopupKit
import BeeKit_Swift

extension AppThemeService {

    static func themeNavigationBar(nav: UINavigationController) {
        nav.navigation.configuration.isEnabled = true
        nav.navigation.configuration.titleTextAttributes = [.font: UIFontMake(17)]
        nav.navigation.configuration.isShadowHidden = true
        nav.navigation.configuration.isTranslucent = false
    }

    static func themeNavigationBar(vc: UIViewController) {
        vc.navigation.bar.titleTextAttributes = [.font: UIFontMake(17)]
        vc.navigation.item.backBarButtonItem = UIBarButtonItem(image: UIImage.iconfont(BEEIconFont.tback(24), color: .black), style: .done, target: nil, action: nil)
    }
}

