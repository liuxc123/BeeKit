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
        nav.navigation.configuration.backItem = UINavigationController.Configuration.BackItem(style: .image(UIImage.iconfont(BEEIconFont.tback(24), color: .black)), tintColor: UIColor(light: .black, dark: .white))
    }
}

