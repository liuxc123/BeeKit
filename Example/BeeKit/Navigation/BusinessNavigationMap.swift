//
//  BusinessNavigationMap.swift
//  BEEKit_Example
//
//  Created by liuxc on 2021/3/15.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit_Swift

struct BusinessNavigationMap {

    /// 注册页面
    static func initialize(navigator: NavigatorType) {

        // BEEKit页面
        navigator.handle("beekit".formatScheme()) { (url, values, context) -> Bool in
            navigator.move(TabBarViewController.self) { (vc) in
                (vc as? UITabBarController)?.selectedIndex = 0
            }
            return true
        }

        // Foundation页面
        navigator.handle("foundation".formatScheme()) { (url, values, context) -> Bool in
            navigator.move(TabBarViewController.self) { (vc) in
                (vc as? UITabBarController)?.selectedIndex = 1
            }
            return true
        }

        // UIKit页面
        navigator.handle("uikit".formatScheme()) { (url, values, context) -> Bool in
            navigator.move(TabBarViewController.self) { (vc) in
                (vc as? UITabBarController)?.selectedIndex = 2
            }
            return true
        }
    }

}
