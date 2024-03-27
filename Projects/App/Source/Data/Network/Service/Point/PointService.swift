//
//  PointService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation
import Moya

enum PointService: ServiceProtocol {
    
    case fetchPoint(_ request: FetchPointRequest)
    case fetchPointScore(_ request: FetchPointScoreRequest)
}

extension PointService {
    
    var baseURL: URL {
        host.appendingPathComponent("point")
    }
    
    var path: String {
        switch self {
        case .fetchPoint: "/my"
        case .fetchPointScore: "/score/my"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPoint: .get
        case .fetchPointScore: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .fetchPoint(request):
            request.toURLParameters()
        case let .fetchPointScore(request):
            request.toURLParameters()
        }
    }
}
