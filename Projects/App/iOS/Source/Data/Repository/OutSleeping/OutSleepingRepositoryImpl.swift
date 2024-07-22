//
//  OutSleepingRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct OutSleepingRepositoryImpl: OutSleepingRepository {
    
    let dataSource: OutSleepingDataSource
    
    func postOutSleeping(_ request: PostOutSleepingRequest) async throws {
        try await dataSource.postOutSleeping(request)
    }
    
    func deleteOutSleeping(id: Int) async throws {
        try await dataSource.deleteOutSleeping(id: id)
    }
    
    func fetchOutSleeping() async throws -> [OutSleepingResponse] {
        try await dataSource.fetchOutSleeping()
    }
}
