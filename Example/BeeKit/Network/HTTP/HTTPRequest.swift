//
//  HTTPRequest.swift
//
//
//  Created by liuxc on 2020/4/7.
//  Copyright © 2020 liuxc. All rights reserved.
//

import Alamofire
import Moya
import BEENetwork

public enum HTTPRequest {
    case request(route: Route, params: [String: Any]?, encode: ParameterEncoding = Alamofire.URLEncoding(), loading: Bool = true)
    case uploadPictures(route: Route, images: [UIImage], params: [String: Any]?, loading: Bool = true)

    static let maxLength: UInt = 2 * 1024 * 1024
}

extension HTTPRequest: SugarTargetType {

    public var baseURL: URL {
        return URL(string: Envs.base_url)!
    }

    public var route: Route {
        switch self {
        case let .request(route, _, _, _):
            return route
        case let .uploadPictures(route, _, _, _):
            return route
        }
    }

    public var parameters: BEENetwork.Parameters? {
        switch self {
        case let .request(_, params, encode, _):
            return Parameters(encoding: encode, values: params ?? [:])
        case .uploadPictures(_, _, _, _):
            return nil
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var headers: [String : String]? {
        return HTTPHeader.http_header
    }

    public var task: Moya.Task {
        switch self {

        case .request(_, _, _, _):
            guard let parameters = self.parameters else { return .requestPlain }
            return .requestParameters(parameters: parameters.values, encoding: parameters.encoding)

        case let .uploadPictures(_, images, params, _):
            let formDataArray = images.map {
                MultipartFormData(provider: .data($0.compress(withLengthLimit: HTTPRequest.maxLength)), name: "file", fileName: "filename_\(Int(Date.now().timeIntervalSince1970)).jpeg", mimeType: "image/jpeg")
            }
            return .uploadCompositeMultipart(formDataArray, urlParameters: params ?? [:])
        }
    }

    public func canLoading() -> (Bool, String) {
        let message = "加载中..."
        switch self {
        case let .request(_, _, _, loading):
            return (loading, message)
        case let .uploadPictures(_, _, _, loading):
            return (loading, message)
        }
    }

}


