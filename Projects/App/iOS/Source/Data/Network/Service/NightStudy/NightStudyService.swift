//
//  NightStudyService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Moya

enum NightStudyService: ServiceProtocol {
    
    case postNightStudy(_ request: PostNightStudyRequest)
    case deleteNightStudy(id: Int)
    case fetchNightStudy
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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postNightStudy: .post
        case .deleteNightStudy: .delete
        case .fetchNightStudy: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .postNightStudy(request):
            request.toJSONParameters()
        case .deleteNightStudy:
                .requestPlain
        case .fetchNightStudy:
                .requestPlain
        }
    }
}
