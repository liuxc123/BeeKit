//
//  AppDelegate.swift
//  BeeKit
//
//  Created by liuxc123 on 12/31/2020.
//  Copyright (c) 2020 liuxc123. All rights reserved.
//

import UIKit
@_exported import BeeKit

@UIApplicationMain
class AppDelegate: BeeApplicationDelegate {

    override var services: [ApplicationService] {
        return [
            DebugingApplicationService(),
            ThirdApplicationService(),
            ThemeApplicationService(),
            NavigationApplicationService(),
            RootApplicationService()
        ]
    }
    
    override init() {
        super.init()
        self.window = Window(frame: UIScreen.main.bounds)
    }
}

