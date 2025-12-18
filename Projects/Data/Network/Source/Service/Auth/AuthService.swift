//
//  AuthService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Moya
import Domain
import Foundation

enum AuthService: ServiceProtocol {
    
    case postLogin(_ request: PostLoginRequest)
    case postReissue(_ request: PostReissueRequest)
    case postQRLogin(_ request: DeepLinkLoginRequest)
}

extension AuthService {

    var baseURL: URL {
        switch self {
        case .postQRLogin:
            return .init(string: Constants.dauthAPI)!
                .appendingPathComponent(host)
        default:
            return .init(string: Constants.API)!
                .appendingPathComponent(host)
        }
    }

    var host: String {
        "auth"
    }
    
    var path: String {
        switch self {
        case .postLogin: "/login"
        case .postReissue: "/reissue"
        case .postQRLogin: "/qr-login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postLogin: .post
        case .postReissue: .post
        case .postQRLogin: .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .postLogin(request):
            request.toJSONParameters()
        case let .postReissue(request):
            request.toJSONParameters()
        case let .postQRLogin(request):
            request.toJSONParameters()
        }
    }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        .none
    }
}
