//
//  OutGoingService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Moya

enum OutGoingService: ServiceProtocol {
    
    case postOutGoing(_ request: PostOutGoingRequest)
    case deleteOutGoing(id: Int)
    case fetchOutGoing
}

extension OutGoingService {
    
    var host: String {
        "out-going"
    }
    
    var path: String {
        switch self {
        case .postOutGoing: ""
        case let .deleteOutGoing(id): "/\(id)"
        case .fetchOutGoing: "/my"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postOutGoing: .post
        case .deleteOutGoing: .delete
        case .fetchOutGoing: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .postOutGoing(request):
            request.toJSONParameters()
        case .deleteOutGoing:
                .requestPlain
        case .fetchOutGoing:
                .requestPlain
        }
    }
}
