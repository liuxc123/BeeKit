//
//  LoggingPlugin.swift
//  BEENetwork_Example
//
//  Created by liuxc on 2021/1/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Moya
import enum Result.Result

class LoggingPlugin: PluginType {

    func willSend(_ request: RequestType, target: TargetType) {}

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case let .success(response):
            do {
                let json = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
                debugPrint(json)
            } catch {
                if let string = String(bytes: response.data, encoding: .utf8) {
                    debugPrint(string)
                } else {
                    debugPrint("response empty")
                }
            }
        case let .failure(e):
            debugPrint(e)
        }
    }
}
