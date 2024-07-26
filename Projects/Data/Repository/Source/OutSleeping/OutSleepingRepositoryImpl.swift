//
//  OutSleepingRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import DataSource
import SwiftBok

@Init()
public struct OutSleepingRepositoryImpl: OutSleepingRepository {
    
    let dataSource: OutSleepingDataSource
    
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
