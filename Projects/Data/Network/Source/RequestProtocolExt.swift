//
//  Request.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation
import Moya
import Domain

extension RequestProtocol {
    
    var host: URL {
        .init(string: Constants.API)!
    }
    
    var headers: [String: String]? {
        var headers = ["Content-Type": "application/json"]
        headers["Authorization"] = "" // TOKEN
        return headers
    }
    
    func toRequestParameters(encoding: ParameterEncoding) -> Moya.Task {
        if let data = try? JSONEncoder().encode(self),
           let object = (try? JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments
           )).flatMap({ $0 as? [String: Any] }) {
            return .requestParameters(
                parameters: object,
                encoding: encoding
            )
        }
        return .requestPlain
    }
    
    func toJSONParameters() -> Moya.Task {
        toRequestParameters(encoding: JSONEncoding.default)
    }
    
    func toURLParameters() -> Moya.Task {
        toRequestParameters(encoding: URLEncoding.default)
    }
}
