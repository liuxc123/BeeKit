//
//  NetworkService.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/3/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import RxSwift
import RxCocoa
import BEENetwork
import ObjectMapper
import BeeKit_Swift

// MARK: - 网络服务类

public struct NetworkService {

    static func request(target: MultiTarget) -> Single<Response> {
        return NetworkManager.default.provider.rx
            .request(MultiTarget(target))
            .mapResponse()
    }
}

/// Token信息
struct TokenModel: Mappable {

    var tokenType: String = ""          //token类型
    var expiresIn: String = ""          //生效时间
    var accessToken: String = ""        //刷新后的token
    var refreshToken: String = ""       //刷新后的刷新token

    init() {}
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        tokenType       <- map["token_type"]
        expiresIn       <- map["expires_in"]
        accessToken     <- map["access_token"]
        refreshToken    <- map["refresh_token"]
    }
}


private struct BaseModel: Mappable {

    var status: Int = 0
    var msg: String = ""
    var time: String = ""
    var data: Any?

    init?(map: Map) {}
    mutating func mapping(map: Map) {
        status <- map["status"]
        msg <- map["msg"]
        time <- map["time"]
        data <- map["data"]
    }
}

extension Moya.Response {

    public func mapResponse() throws -> Moya.Response {

        let response = self

        guard let model = try? response.mapObject(BaseModel.self) else {
            throw BEEError(domain: "网络错误，请稍后再试！", code: 5000, userInfo: nil)
        }

        if model.status != 2000 {
            throw BEEError(domain: model.msg, code: model.status, userInfo: nil)
        }

        var JSONData: Data!
        if let data = model.data, JSONSerialization.isValidJSONObject(data) {
            do {
                JSONData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            } catch {
                throw BEEError(domain: "网络错误，请稍后再试！", code: model.status, userInfo: nil)
            }
        }
        
        return Response(statusCode: response.statusCode, data: JSONData, request: response.request, response: response.response)
    }
}

extension ObservableType where Element == Response {

    public func mapResponse() -> Observable<Element> {
        return flatMap { Observable.just(try $0.mapResponse()) }
                .catchError({ (error) in
                    if let error = error as? Moya.MoyaError {
                        return .error(BEEError(domain: "网络错误，请稍后再试！", code: error.errorCode, userInfo: error.errorUserInfo))
                    }
                    return .error(error)
                })
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {

    public func mapResponse() -> Single<Element> {
        return flatMap { .just(try $0.mapResponse()) }
            .catchError({ (error) in
                if let error = error as? Moya.MoyaError {
                    return .error(BEEError(domain: "网络错误，请稍后再试！", code: error.errorCode, userInfo: error.errorUserInfo))
                }
                return .error(error)
            })
    }
}
