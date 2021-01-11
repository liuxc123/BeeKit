//
//  PageModel.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import ObjectMapper

// MARK: 分页策略
struct PageStrategy {
    static let pagesize: Int = 10
}

// MARK: - 解析分页 data是对象类型
struct PageModel<T: Mappable>: Mappable {

    var data: T?                //数据主体
    var pager = PagerModel()    //分页信息

    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        data <- map["data"]
        pager <- map["pager"]
    }
}

// MARK: - 解析分页 data是数组类型
struct PageArrayModel<T: Mappable>: Mappable {

    var data: [T]?              //数据主体
    var pager = PagerModel()    //分页信息

    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        data <- map["data"]
        pager <- map["pager"]
    }
}

struct PagerModel: Mappable {

    var currentPage: Int = 0        //当前页码
    var lastPage: Int = 0           //最后一页页码
    var total: Int = 0              //数据总数

    var isLastPage: Bool {
        return currentPage == lastPage
    }

    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        currentPage <- map["current_page"]
        lastPage <- map["last_page"]
        total <- map["total"]
    }
}

