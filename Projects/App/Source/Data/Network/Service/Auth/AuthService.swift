//
//  AuthService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation
import Moya

enum AuthService: ServiceProtocol {
    
    case login(_ request: LoginRequest)
    case reissue(_ request: ReissueRequest)
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
        case let .login(request):
            request.toJSONParameters()
        case let .reissue(request):
            request.toJSONParameters()
        }
    }
}
