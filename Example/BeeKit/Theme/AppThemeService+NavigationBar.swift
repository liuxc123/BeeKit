//
//  AppTheme+NavigationBar.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BEEPopupKit
import BeeKit

extension AppThemeService {

    static func themeNavigationBar(nav: UINavigationController) {
        nav.navigation.configuration.isEnabled = true
        nav.navigation.configuration.titleTextAttributes = [.font: UIFontMake(17)]
        nav.navigation.configuration.isShadowHidden = true
        nav.navigation.configuration.isTranslucent = false
        nav.navigation.configuration.backItem = UINavigationController.Configuration.BackItem(style: .image(UIImage.iconfont(BEEIconFont.tback(24), color: .black)), tintColor: .black)
        nav.navigation.configuration.tintColor = .white
        nav.navigation.configuration.barTintColor = .white
    }

    static func themeNavigationBar(vc: UIViewController) {
        vc.navigation.bar.titleTextAttributes = [.foregroundColor: UIColorHexMake("#272727"),
                                                            .font: UIFontMake(17)]
        vc.navigation.bar.isShadowHidden = true
        vc.navigation.bar.isTranslucent = false
        vc.navigation.bar.tintColor = UIColorHexMake("#666666")
    }

}

