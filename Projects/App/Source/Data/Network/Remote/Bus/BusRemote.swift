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
        try await self.request(target: .fetchAllBus)
            .map(Response<[BusResponse]>.self, using: decoder)
    }
    
    func fetchAppliedBus() async throws -> Response<BusResponse?> {
        try await self.request(target: .fetchAppliedBus)
            .map(Response<BusResponse?>.self, using: decoder)
    }
    
    func postApplyBus(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .postApplyBus(id: id))
            .map(DefaultResponse.self, using: decoder)
    }
    
    func patchAppliedBus(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .patchAppliedBus(id: id))
            .map(DefaultResponse.self, using: decoder)
    }
    
    func deleteAppliedBus(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .deleteAppliedBus(id: id))
            .map(DefaultResponse.self, using: decoder)
    }
}
