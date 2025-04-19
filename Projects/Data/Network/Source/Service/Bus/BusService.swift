//
//  BusService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Moya

enum BusService: ServiceProtocol {
    
    case fetchAllBus
    case fetchAppliedBus
    case fetchBusSeats(id: Int)
    case fetchQrCode
    case patchBusStatus(id: Int, seatNumber: Int)
    case applyBus(id: Int, seatNumber: Int)
}

extension BusService {
    
    var host: String {
        "bus"
    }
    
    var path: String {
        switch self {
        case .fetchAllBus: ""
        case .fetchAppliedBus: "/apply"
        case let .fetchBusSeats(id): "/\(id)/seats"
        case .fetchQrCode: "/qr-code/nonce"
        case let .patchBusStatus(id, seatNumber): "/apply/status/\(id)/\(seatNumber)"
        case let .applyBus(id, seatNumber): "/apply/\(id)/\(seatNumber)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAllBus: .get
        case .fetchAppliedBus: .get
        case .fetchBusSeats: .get
        case .fetchQrCode: .get
        case .patchBusStatus: .patch
        case .applyBus: .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchAllBus:
                .requestPlain
        case .fetchAppliedBus:
                .requestPlain
        case .fetchBusSeats:
                .requestPlain
        case .fetchQrCode:
                .requestPlain
        case .patchBusStatus:
                .requestPlain
        case .applyBus:
                .requestPlain
        }
    }
}
