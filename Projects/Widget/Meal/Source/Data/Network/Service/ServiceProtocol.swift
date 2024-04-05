//
//  ServiceProtocol.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

import Foundation
import Moya

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
        return headers
    }
}
