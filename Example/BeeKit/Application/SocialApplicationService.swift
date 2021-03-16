//
//  SocialApplicationService.swift
//  CommonApp
//
//  Created by liuxc on 2020/12/30.
//

import UIKit
import BeeKit_Swift
import MonkeyKing

class SocialApplicationService: NSObject, ApplicationService {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        MonkeyKing.registerLaunchFromWeChatMiniAppHandler { messageExt in
            log.info("messageExt:", messageExt)
        }

        return true
    }

    /// URL路由跳转
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return MonkeyKing.handleOpenURL(url)
    }

    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return MonkeyKing.handleOpenURL(url)
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return MonkeyKing.handleOpenUserActivity(userActivity)
    }

}
