//
//  DebugingApplicationService.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import DoraemonKit

class DebugingApplicationService: NSObject, ApplicationService {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        setupDoraemonKit()

        return true
    }

    func setupDoraemonKit() {
        DoraemonManager.shareInstance().addH5DoorBlock { (url) in
            navigator.push(url)
        }
        DoraemonManager.shareInstance().install()
    }
}
