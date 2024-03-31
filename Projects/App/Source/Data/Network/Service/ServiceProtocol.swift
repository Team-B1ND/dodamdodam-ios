//
//  ServiceProtocol.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation
import Moya
import SignKit

protocol ServiceProtocol: TargetType {
    
    var host: String { get }
}

extension ServiceProtocol {
    
    var baseURL: URL {
        .init(string: Constants.API)!
        .appendingPathComponent(host)
    }
    
    var headers: [String: String]? {
        var headers = ["Content-Type": "application/json"]
        if let authorization = Sign.accessToken {
            headers["Authorization"] = "Bearer \(authorization)"
        }
        return headers
    }
}
