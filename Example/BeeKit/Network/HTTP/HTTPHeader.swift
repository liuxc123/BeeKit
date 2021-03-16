//
//  HTTPHeaderModel.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/3/16.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Device

/// 请求头信息
struct HTTPHeader {

    /// 客户端类型
    static let clientType: String = "APP"

    /// 设备号
    static var deviceNum: String = ""

    /// 手机品牌
    static let phoneBrand: String = "\(Device.type())"

    /// 手机型号
    static let phoneModel: String = "\(Device.version())"

    /// 系统名称_版本号
    static let systemName: String = "\(UIDevice.current.systemName)_\((UIDevice.current.systemVersion as NSString).floatValue)"

    /// APP版本号
    static let appVersion: String = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""

    /// SDKVersion
    static let sdkVersion: String = ""

    /// 推送号
    static var notifationNum: String {
        return "Jpush,registrationID"
    }

    /// 网络类型
    static var networkType: String {
        return "No Connection"
    }

    /// APP内部版本号
    static let appCode: String = "\(Envs.appCode)"

    /// 应用市场名称 AppStore
    static let channel: String = "App Store"

    /// APP 唯一标识
    static var appUUID: String {
        return ""
    }

    ///请求头部
    static var http_header: [String: String] {
        var header: [String: String] = [:]

        header["APP-TYPE"] = "iOS_fleet"
        header["APP-PUSH"] = HTTPHeader.notifationNum
        header["APP-CODE"] = HTTPHeader.appCode
        header["APP-UID"] = HTTPHeader.appUUID

        header["APP-SYSTEM"] = "\(HTTPHeader.deviceNum),\(HTTPHeader.phoneBrand),\(HTTPHeader.systemName),\(HTTPHeader.channel),\(SCREEN_WIDTH)*\(SCREEN_HEIGHT)"

        return header
    }
}

