//
//  BusDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Network
import Domain

public struct BusDataSource: DataSourceProtocol {
    let remote: BusRemote
    
    public init(remote: BusRemote) {
        self.remote = remote
    }
    
    public func fetchAllBus() async throws -> [BusResponse] {
        let response = try await remote.fetchAllBus()
        return response.data
    }
    
    public func fetchAppliedBus() async throws -> BusResponse? {
        let response = try await remote.fetchAppliedBus()
        return response.data
    }
    
    public func postApplyBus(id: Int) async throws {
        _ = try await remote.postApplyBus(id: id)
    }
    
    public func patchAppliedBus(id: Int) async throws {
        _ = try await remote.patchAppliedBus(id: id)
    }
    
    public func deleteAppliedBus(id: Int) async throws {
        _ = try await remote.deleteAppliedBus(id: id)
    }
}
