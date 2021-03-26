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

    static func createManager() -> NetworkManager {
        let configuration = Configuration()
        return NetworkManager(configuration: configuration)
    }

    // TODO: 登录
    static func login(phone: String, password: String) -> Single<TokenModel> {
        let params: [String : Any] = ["phone": phone, "password": password]
        let target = HTTPRequest.request(route: .post("/login"), params: params)
        return NetworkManager.default.provider.rx
            .request(MultiTarget(target))
            .mapResponse()
            .catchError({ (error) -> Single<Response> in
                if let error = error as? Moya.MoyaError {
                    return .error(BEEError(domain: "网络错误，请稍后再试！", code: error.errorCode, userInfo: error.errorUserInfo))
                }
                return .error(error)
            })
            .mapObject(TokenModel.self)
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


struct BaseModel: Mappable {

    var code: Int = 0
    var data: Any?

    init?(map: Map) {}
    mutating func mapping(map: Map) {
        code <- map["code"]
        data <- map["data"]
    }
}


extension Moya.Response {

    public func mapResponse() throws -> Moya.Response {

        let response = self

        guard let model = try? response.mapObject(BaseModel.self) else {
            throw BEEError(domain: "网络错误，请稍后再试！", code: 5000, userInfo: nil)
        }
        if model.code != 0 {
            throw BEEError(domain: "网络错误，请稍后再试！", code: model.code, userInfo: nil)
        }


        var JSONData: Data!
        if let data = model.data, JSONSerialization.isValidJSONObject(data) {
            do {
                JSONData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            } catch {
                JSONData = Data()
            }
        }
        
        return Response(statusCode: response.statusCode, data: JSONData, request: response.request, response: response.response)
    }
}

extension ObservableType where Element == Response {

    public func mapResponse() -> Observable<Element> {
        return flatMap { Observable.just(try $0.mapResponse()) }
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {

    public func mapResponse() -> Single<Element> {
        return flatMap { .just(try $0.mapResponse()) }
    }
}
