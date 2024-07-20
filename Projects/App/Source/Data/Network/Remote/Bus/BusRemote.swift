//
//  BusRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation

struct BusRemote: RemoteProtocol {
    
    typealias Target = BusService
    
    func fetchAllBus() async throws -> Response<[BusResponse]> {
        try await self.request(target: .fetchAllBus, res: [BusResponse].self)
    }
    
    func fetchAppliedBus() async throws -> Response<BusResponse?> {
        try await self.request(target: .fetchAppliedBus, res: BusResponse?.self)
    }
    
    func postApplyBus(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .postApplyBus(id: id))
    }
    
    func patchAppliedBus(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .patchAppliedBus(id: id))
    }
    
    func deleteAppliedBus(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .deleteAppliedBus(id: id))
    }
}
