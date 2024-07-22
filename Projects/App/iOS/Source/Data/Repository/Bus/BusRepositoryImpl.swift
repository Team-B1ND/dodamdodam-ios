//
//  BusRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct BusRepositoryImpl: BusRepository {
    
    let dataSource: BusDataSource
    
    func fetchAllBus() async throws -> [BusResponse] {
        try await dataSource.fetchAllBus()
    }
    
    func fetchAppliedBus() async throws -> BusResponse? {
        try await dataSource.fetchAppliedBus()
    }
    
    func postApplyBus(id: Int) async throws {
        try await dataSource.postApplyBus(id: id)
    }
    
    func patchAppliedBus(id: Int) async throws {
        try await dataSource.patchAppliedBus(id: id)
    }
    
    func deleteAppliedBus(id: Int) async throws {
        try await dataSource.deleteAppliedBus(id: id)
    }
}
