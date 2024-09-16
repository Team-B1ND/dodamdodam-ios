//
//  OutSleepingRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import DataSource

public struct OutSleepingRepositoryImpl: OutSleepingRepository {
    
    let dataSource: OutSleepingDataSource
    
    public init(dataSource: OutSleepingDataSource) {
        self.dataSource = dataSource
    }
    
    public func postOutSleeping(_ request: PostOutSleepingRequest) async throws {
        try await dataSource.postOutSleeping(request)
    }
    
    public func deleteOutSleeping(id: Int) async throws {
        try await dataSource.deleteOutSleeping(id: id)
    }
    
    public func fetchOutSleeping() async throws -> [OutSleepingResponse] {
        try await dataSource.fetchOutSleeping()
    }
}
