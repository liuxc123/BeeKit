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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        setupWindow()

        return true
    }
    
    func setupWindow() {
        let tabbar = TabBarViewController()
        self.window?.rootViewController = tabbar
    }

}
