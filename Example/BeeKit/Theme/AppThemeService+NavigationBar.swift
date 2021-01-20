//
//  AppTheme+NavigationBar.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

extension AppThemeService {

    static func themeNavigationBar(nav: UINavigationController) {
        nav.navigation.configuration.isEnabled = true
        nav.navigation.configuration.titleTextAttributes = [.foregroundColor: UIColorHexMake("#272727"),
                                                            .font: UIFontMake(17)]
        nav.navigation.configuration.isShadowHidden = true
        nav.navigation.configuration.isTranslucent = false
        nav.navigation.configuration.backItem = UINavigationController.Configuration.BackItem(style: .image(UIImage.iconfont(BEEIconFont.tback(24), color: .black)), tintColor: .black)
        nav.navigation.configuration.tintColor = UIColorHexMake("#666666")
        nav.navigation.configuration.setBackgroundImage(UIImage(color: .white, size: CGSize(width: 1, height: 1)))
    }

}
