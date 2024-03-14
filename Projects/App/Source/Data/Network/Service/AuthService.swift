//
//  AuthService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation
import Moya

enum AuthService: TargetType {
    
    case login(id: String, pw: String)
    case reissue(refreshToken: String)
}

extension AuthService {
    
    var baseURL: URL {
        host.appendingPathComponent("auth")
    }
    
    var path: String {
        switch self {
        case .login: "/login"
        case .reissue: "/reissue"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login: .post
        case .reissue: .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .login(id, pw):
                .requestParameters(
                    parameters: ["id": id, "pw": pw],
                    encoding: JSONEncoding.default
                )
        case let .reissue(refreshToken):
                .requestParameters(
                    parameters: ["refreshToken": refreshToken],
                    encoding: JSONEncoding.default
                )
        }
    }
}
