//
//  NetworkService+User.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import BEENetwork
import RxSwift
import RxCocoa

extension NetworkService {

    // TODO: 检查更新
    static func versionCheck() -> Single<Response> {
        let target = HTTPRequest.request(route: .get("/version/check"), params: nil, loading: false)
        return NetworkService.request(target: MultiTarget(target))
    }
}
