//
//  NightStudyService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Moya
import Domain

enum NightStudyService: ServiceProtocol {
    
    case postNightStudy(_ request: PostNightStudyRequest)
    case deleteNightStudy(id: Int)
    case fetchNightStudy
    case checkBanStatus
}

extension NightStudyService {
    
    var host: String {
        "night-study"
    }
    
    var path: String {
        switch self {
        case .postNightStudy: ""
        case let .deleteNightStudy(id): "/\(id)"
        case .fetchNightStudy: "/my"
        case .checkBanStatus: "/ban/my"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postNightStudy: .post
        case .deleteNightStudy: .delete
        case .fetchNightStudy, .checkBanStatus: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .postNightStudy(request):
            request.toJSONParameters()
        case .deleteNightStudy, .fetchNightStudy, .checkBanStatus:
                .requestPlain
        }
    }
}
