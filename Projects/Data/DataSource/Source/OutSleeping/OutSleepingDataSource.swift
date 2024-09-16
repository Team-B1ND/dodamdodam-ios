//
//  OutSleepingDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import Network

public struct OutSleepingDataSource: DataSourceProtocol {
    let remote: OutSleepingRemote
    
    public init(remote: OutSleepingRemote) {
        self.remote = remote
    }
    
    public func postOutSleeping(_ request: PostOutSleepingRequest) async throws {
        _ = try await remote.postOutSleeping(request)
    }
    
    public func deleteOutSleeping(id: Int) async throws {
        _ = try await remote.deleteOutSleeping(id: id)
    }
    
    public func fetchOutSleeping() async throws -> [OutSleepingResponse] {
        let response = try await remote.fetchOutSleeping()
        return response.data
    }
}
