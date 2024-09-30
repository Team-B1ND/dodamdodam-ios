//
//  BusRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation
import Domain

public struct BusRemote: RemoteProtocol {
    typealias Target = BusService
    
    public init() {}
    
    public func fetchAllBus() async throws -> Response<[BusResponse]> {
        try await self.request(target: .fetchAllBus, res: [BusResponse].self)
    }
    
    public func fetchAppliedBus() async throws -> Response<BusResponse?> {
        try await self.request(target: .fetchAppliedBus, res: BusResponse?.self)
    }
    
    public func postApplyBus(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .postApplyBus(id: id))
    }
    
    public func patchAppliedBus(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .patchAppliedBus(id: id))
    }
    
    public func deleteAppliedBus(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .deleteAppliedBus(id: id))
    }
}
