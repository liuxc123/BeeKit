//
//   RootApplicationService.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit

class RootApplicationService: NSObject, ApplicationService {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
            
        setupNavigator()
        
        setupWindow()

        setupTheme()

        return true
    }
    
    func setupNavigator() {
        NavigationMap.initialize(navigator: navigator)
    }
    
    func setupWindow() {
        let nav = UINavigationController(rootViewController: ViewController())
        nav.navigation.configuration.isEnabled = true
        self.window?.rootViewController = nav
    }

    func setupTheme() {
        if #available(iOS 13.0, *), UITraitCollection.current.userInterfaceStyle == .dark {
            ThemeManager.shared.changeTheme(to: .dark)
        } else {
            ThemeManager.shared.changeTheme(to: .light)
        }
    }
    
}
