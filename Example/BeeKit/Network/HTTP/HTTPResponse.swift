//
//  HTTPDataResponse.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/3/16.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Moya
import BEENetwork
import BeeKit_Swift
import ObjectMapper

struct HTTPResponse: Mappable {

    var status: Int = 0
    var time: String = ""
    var desc: String = ""
    var _data: Any?
    var data: Response = Response(statusCode: 200, data: Data())

    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {

    }

    func makeCustomNetworkError() -> BEEError? {
        switch status {
        case 2000:
            return nil
        default:
            return BEEError(domain: desc, code: status, userInfo: ["time": time])
        }
    }
}
