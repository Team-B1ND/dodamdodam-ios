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
        return ["Content-Type": "application/json"]
    }
    var validationType: ValidationType { .successCodes }
}
