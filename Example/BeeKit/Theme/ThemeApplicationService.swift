//
//  ThemeApplicationService.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit

class ThemeApplicationService: NSObject, ApplicationService {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        setupTheme()

        setupHUD()

        return true
    }

    func setupTheme() {
        if #available(iOS 13.0, *), UITraitCollection.current.userInterfaceStyle == .dark {
            ThemeManager.shared.changeTheme(to: .dark)
        } else {
            ThemeManager.shared.changeTheme(to: .light)
        }
    }

    func setupHUD() {
        BEEHUDConfig.shared.backgroundStyle = .solidColor
        BEEHUDConfig.shared.backgroundColor = .white
        BEEHUDConfig.shared.contentColor = .black
        BEEHUDConfig.shared.animationType = .zoomIn
    }

}
