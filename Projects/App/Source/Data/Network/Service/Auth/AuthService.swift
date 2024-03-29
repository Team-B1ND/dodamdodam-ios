//
//  AuthService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation
import Moya

enum AuthService: ServiceProtocol {
    
    case postLogin(_ request: PostLoginRequest)
    case postReissue(_ request: PostReissueRequest)
}

extension AuthService {
    
    var baseURL: URL {
        host.appendingPathComponent("auth")
    }
    
    var path: String {
        switch self {
        case .postLogin: "/login"
        case .postReissue: "/reissue"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postLogin: .post
        case .postReissue: .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .postLogin(request):
            request.toJSONParameters()
        case let .postReissue(request):
            request.toJSONParameters()
        }
    }
}
