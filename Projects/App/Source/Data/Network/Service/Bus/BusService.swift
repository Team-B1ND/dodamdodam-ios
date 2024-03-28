//
//  BusService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation
import Moya

enum BusService: ServiceProtocol {
    
    case fetchAllBus
    case fetchAppliedBus
    case postApplyBus(id: Int)
    case patchAppliedBus(id: Int)
    case deleteAppliedBus(id: Int)
}

extension BusService {
    
    var baseURL: URL {
        host.appendingPathComponent("bus")
    }
    
    var path: String {
        switch self {
        case .fetchAllBus: ""
        case .fetchAppliedBus: "/apply"
        case let .postApplyBus(id): "/apply/\(id)"
        case let .patchAppliedBus(id): "/apply/\(id)"
        case let .deleteAppliedBus(id): "/apply\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAllBus: .get
        case .fetchAppliedBus: .get
        case .postApplyBus: .post
        case .patchAppliedBus: .patch
        case .deleteAppliedBus: .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchAllBus:
                .requestPlain
        case .fetchAppliedBus:
                .requestPlain
        case .postApplyBus:
                .requestPlain
        case .patchAppliedBus:
                .requestPlain
        case .deleteAppliedBus:
                .requestPlain
        }
    }
}
