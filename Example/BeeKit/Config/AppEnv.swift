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
    }

    /// 环境变量
    public static var envMode: EnvsMode {
        return .dev
    }

    /// app内部版本号（ v1.0.4 code=5 ）
    static let appCode: Int = 5

}


public extension EnvsProtocol {

    static var base_url: String {
        switch Envs.envMode {
        case .dev: return "http://dev.api.fleet.webus.vip:12321/fleet/api/v1/mobile"
        }
    }

    static var h5_url: String {
        switch Envs.envMode {
        case .dev: return "http://dev.app.fleeth5.webus.vip:12321"
        }
    }

}
