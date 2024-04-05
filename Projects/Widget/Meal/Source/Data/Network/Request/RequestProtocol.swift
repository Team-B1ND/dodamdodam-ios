//
//  RequestProtocol.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

import Foundation
import Moya

protocol RequestProtocol: Encodable {
    
    func toRequestParameters(encoding: ParameterEncoding) -> Moya.Task
    
    func toJSONParameters() -> Moya.Task
    
    func toURLParameters() -> Moya.Task
}

extension RequestProtocol {
    
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
