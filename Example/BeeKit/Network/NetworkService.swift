//
//  NetworkService.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/3/16.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya

// MARK: - 网络服务类

public struct NetworkService {

    static func request(_ target: TargetType,
                        progress: ProgressBlock? = nil,
                        timeout: TimeInterval = 60,
                        test: Bool = false) -> Single<HTTPResponse> {

        let configuration = Configuration()
        configuration.timeoutInterval = timeout
        let manager = NetworkManager(configuration: configuration)
        return manager.provider.rx
            .request(MultiTarget(target))
            .mapObject(HTTPResponse.self)
    }

}
