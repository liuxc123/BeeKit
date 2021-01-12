//
//  AppThemeService.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import BeeKit

public class AppThemeService {
    static let shared = AppThemeService()
    let configs: [String: [String: String]]

    init() {
        let plistPath = Bundle.main.path(forResource: "AppTheme", ofType: "plist")
        if plistPath == nil {
            configs = [String: [String: String]]()
        }else {
            let sources = NSDictionary(contentsOfFile: plistPath!) as? [String: [String: String]]
            if sources == nil {
                configs = [String: [String: String]]()
            }else {
                configs = sources!
            }
        }
    }

    func themeColor(style: ThemeStyle, level: ThemeLevel) -> UIColor {
        if let hex = configs[style.rawValue]?[level.rawValue] {
            return UIColor(hexString: hex) ?? .clear
        } else {
            //可以根据需求配置默认色
            return UIColor.black
        }
    }
}
