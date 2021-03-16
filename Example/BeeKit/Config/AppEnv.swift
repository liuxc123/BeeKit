//
//  AppEnv.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

public protocol EnvsProtocol {}

public class Envs: EnvsProtocol {

    public enum EnvsMode: Int {
        case dev        = 0
        case test       = 1
        case product    = 2
    }

    /// 环境变量
    public static var envMode: EnvsMode {
//        #if DEBUG
//        if let env = UserDefaults.standard.value(forKey: "app_network_env") as? Int {
//            return EnvsMode(rawValue: env) ?? .dev
//        }
//        return .test
//        #else
//        return .product
//        #endif
        return .dev
    }

    /// app内部版本号（ v1.0.4 code=5 ）
    static let appCode: Int = 5

}


public extension EnvsProtocol {

    static var base_url: String {
        switch Envs.envMode {
        case .dev: return "http://dev.api.fleet.webus.vip:12321/fleet/api/v1/mobile"
        case .test: return "http://test.api.fleet.webus.vip:12321/fleet/api/v1/mobile"
        case .product: return "http://call.fleet.ubus.vip/fleet/api/v1/mobile"
        }
    }

    static var h5_url: String {
        switch Envs.envMode {
        case .dev: return "http://dev.app.fleeth5.webus.vip:12321"
        case .test: return "http://test.app.fleeth5.webus.vip:12321"
        case .product: return "http://fleeth5.ubus.vip"
        }
    }

}
