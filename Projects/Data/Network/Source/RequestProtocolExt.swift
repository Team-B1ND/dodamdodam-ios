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
                var queryItems: [String: Any] = [:]
                
                for (key, value) in modifiedObject {
                    if let array = value as? [String] {
                        queryItems[key] = array.joined(separator: ",")
                    } else if let array = value as? [Int] {
                        queryItems[key] = array.map { "\($0)" }.joined(separator: ",")
                    } else {
                        queryItems[key] = value
                    }
                }
                
                return .requestParameters(
                    parameters: queryItems,
                    encoding: URLEncoding.queryString
                )
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
        toRequestParameters(encoding: URLEncoding.queryString)
    }
}

extension [Int] {
    func toURLParameterValue() -> String {
        return self.map { "\($0)" }.joined(separator: ",")
    }
}

extension [String] {
    func toURLParameterValue() -> String {
        return self.joined(separator: ",")
    }
}
