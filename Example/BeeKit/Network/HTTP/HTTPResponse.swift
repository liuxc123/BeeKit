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
    var data: Response = Response(statusCode: 200, data: Data())

    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {

    }
}
