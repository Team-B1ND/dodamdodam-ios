//
//  ServiceProtocol.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation
import Moya

protocol ServiceProtocol: TargetType {
    
    var host: URL { get }
    var headers: [String: String]? { get }
}

extension ServiceProtocol {
    
    var host: URL {
        .init(string: Constants.API)!
    }
    
    var headers: [String: String]? {
        var headers = ["Content-Type": "application/json"]
        headers["Authorization"] = "" // TOKEN
        return headers
    }
}
