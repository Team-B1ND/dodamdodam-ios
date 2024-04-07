//
//  BannerService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Moya

enum BannerService: ServiceProtocol {
    
    case fetchActiveBanner
}

extension BannerService {
    
    var host: String {
        "banner"
    }
    
    var path: String {
        switch self {
        case .fetchActiveBanner: "/active"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchActiveBanner: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchActiveBanner:
                .requestPlain
        }
    }
}
