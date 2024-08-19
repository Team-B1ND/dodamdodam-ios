//
//  BusRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import DataSource
import Domain
import SwiftBok

@Init()
public struct BusRepositoryImpl: BusRepository {
    
    let dataSource: BusDataSource
    
    public func fetchAllBus() async throws -> [BusResponse] {
        try await dataSource.fetchAllBus()
    }
    
    public func fetchAppliedBus() async throws -> BusResponse? {
        try await dataSource.fetchAppliedBus()
    }
    
    public func postApplyBus(id: Int) async throws {
        try await dataSource.postApplyBus(id: id)
    }
    
    public func patchAppliedBus(id: Int) async throws {
        try await dataSource.patchAppliedBus(id: id)
    }
    
    public func deleteAppliedBus(id: Int) async throws {
        try await dataSource.deleteAppliedBus(id: id)
    }
}
