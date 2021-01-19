//
//  NavigationApplicationService.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit

class NavigationApplicationService: NSObject, ApplicationService {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        setupNavigationMap()

        return true
    }

    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return handleOpen(url: url)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return handleOpen(url: url)
    }

    func handleOpen(url: URL) -> Bool {
        // Try push the URL first
        if navigator.push(url) != nil {
            log.debug("[Navigator] push: \(url)")
            return true
        }

        // Try presenting the URL first
        if navigator.present(url) != nil {
            log.debug("[Navigator] present: \(url)")
            return true
        }

        // Try opening the URL
        if navigator.open(url) == true {
            log.debug("[Navigator] open: \(url)")
            return true
        }

        return false
    }

    func setupNavigationMap() {
        NavigationMap.initialize(navigator: navigator)
    }

}
