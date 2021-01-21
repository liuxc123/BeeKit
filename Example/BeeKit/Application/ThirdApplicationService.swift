//
//  ThirdApplicationService.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
@_exported import SnapKit
@_exported import PinLayout
@_exported import BEENetwork

class ThirdApplicationService: NSObject, ApplicationService {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        if #available(iOS 13.0, *) {
            UIColor { (traitCollection) -> UIColor in
                return UIColor.black
            }
        }
        return true
    }

}
