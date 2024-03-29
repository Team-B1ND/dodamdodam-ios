//
//  OutSleepingDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct OutSleepingDataSource: DataSourceProtocol {
    
    let remote: OutSleepingRemote
    
    func postOutSleeping(_ request: PostOutSleepingRequest) async throws {
        _ = try await remote.postOutSleeping(request)
    }
    
    func deleteOutSleeping(id: Int) async throws {
        _ = try await remote.deleteOutSleeping(id: id)
    }
    
    func fetchOutSleeping() async throws -> [OutSleepingResponse] {
        let response = try await remote.fetchOutSleeping()
        return response.data
    }
}
