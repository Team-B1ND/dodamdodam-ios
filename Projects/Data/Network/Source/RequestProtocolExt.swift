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
    
    func toRequestParameters(encoding: ParameterEncoding) -> Moya.Task {
        if let data = try? JSONEncoder().encode(self),
           let object = (try? JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments
           )).flatMap({ $0 as? [String: Any] }) {
            var modifiedObject = object
            
            if encoding is URLEncoding {
                modifiedObject = object.mapValues { value in
                    if let array = value as? [CustomStringConvertible] {
                        return array.map { "\($0)" }.joined(separator: ",")
                    }
                    return value
                }
            }
            
            return .requestParameters(
                parameters: modifiedObject,
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

extension [Int] {
    func toURLParameterValue() -> String {
        return self.map { "\($0)" }.toURLParameterValue()
    }
}

extension [String] {
    func toURLParameterValue() -> String {
        return self.joined(separator: ",")
    }
}
