//
//  NavigationMap.swift
//  CommonApp
//
//  Created by liuxc on 2020/10/14.
//

import UIKit
import BeeKit

public let navigator = Navigator()

protocol NavigationProtocol {
    static var scheme: String { get set }
    static var that: NavigatorType? { get set }
}

extension Navigator: NavigationProtocol {
    /// 用于缓存自己，全局对象只有一个Navigator实例，用于跳转路由
    public static var that: NavigatorType? = nil

    /// 用于缓存scheme
    public static var scheme: String = "beekit"
}

extension String {

    /// 拼接路由URL
    /// - Parameters:
    ///   - scheme: scheme
    ///   - query: query参数
    public func formatScheme(scheme: String = Navigator.scheme,
                             query: [String: Any]? = nil) -> String {
        if let query = query?.sorted(by: { $0.0 < $1.0 }).map({ "\($0)=\($1)" }).joined(separator: "&"), !query.isEmpty {
            return "\(scheme)://\(self)?\(query)"
        }
        return "\(scheme)://\(self)"
    }
}

struct NavigationMap {

    /// 注册页面
    static func initialize(navigator: NavigatorType) {
        CommonNavigationMap.initialize(navigator: navigator)
    }
}

