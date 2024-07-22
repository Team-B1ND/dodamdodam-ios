//
//  OutSleepingService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Moya
import Domain

enum OutSleepingService: ServiceProtocol {
    
    case postOutSleeping(_ request: PostOutSleepingRequest)
    case deleteOutSleeping(id: Int)
    case fetchOutSleeping
}

extension OutSleepingService {
    
    var host: String {
        "out-sleeping"
    }
    
    var path: String {
        switch self {
        case .postOutSleeping: ""
        case let .deleteOutSleeping(id): "/\(id)"
        case .fetchOutSleeping: "/my"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postOutSleeping: .post
        case .deleteOutSleeping: .delete
        case .fetchOutSleeping: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .postOutSleeping(request):
            request.toJSONParameters()
        case .deleteOutSleeping:
                .requestPlain
        case .fetchOutSleeping:
                .requestPlain
        }
    }
}
