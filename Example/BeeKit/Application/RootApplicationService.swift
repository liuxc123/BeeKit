//
//   RootApplicationService.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit
import EachNavigationBar

class RootApplicationService: NSObject, ApplicationService {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
            
        setupNavigator()
        
        setupWindow()
        
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
    
}
