//
//  BusDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct BusDataSource: DataSourceProtocol {
    
    let remote: BusRemote
    
    func fetchAllBus() async throws -> [BusResponse] {
        let response = try await remote.fetchAllBus()
        return response.data
    }
    
    func fetchAppliedBus() async throws -> BusResponse? {
        let response = try await remote.fetchAppliedBus()
        return response.data
    }
    
    func postApplyBus(id: Int) async throws {
        _ = try await remote.postApplyBus(id: id)
    }
    
    func patchAppliedBus(id: Int) async throws {
        _ = try await remote.patchAppliedBus(id: id)
    }
    
    func deleteAppliedBus(id: Int) async throws {
        _ = try await remote.deleteAppliedBus(id: id)
    }
}
