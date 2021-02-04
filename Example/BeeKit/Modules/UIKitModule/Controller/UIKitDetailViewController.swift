//
//  UIKitDetailViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit_Swift

class UIScreenViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "UIScreen"

        log.info("width: \(UIScreen.screenWidth)")
        log.info("height: \(UIScreen.screenHeight)")
        log.info("onePixle: \(UIScreen.onePixle)")
        log.info("safeAreaInsets: \(UIScreen.safeAreaInsets)")
        log.info("statusBar: \(UIScreen.statusBar)")
        log.info("navBar: \(UIScreen.navBar)")
        log.info("topBar: \(UIScreen.topBar)")
        log.info("tabBar: \(UIScreen.tabBar)")
        log.info("bottomBar: \(UIScreen.bottomBar)")
    }
}
