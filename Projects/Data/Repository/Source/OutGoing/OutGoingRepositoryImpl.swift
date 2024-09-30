//
//  OutGoingRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import DataSource

public struct OutGoingRepositoryImpl: OutGoingRepository {
    
    let dataSource: OutGoingDataSource
    
    public init(dataSource: OutGoingDataSource) {
        self.dataSource = dataSource
    }
    
    public func postOutGoing(_ request: PostOutGoingRequest) async throws {
        try await dataSource.postOutGoing(request)
    }
    
    public func deleteOutGoing(id: Int) async throws {
        try await dataSource.deleteOutGoing(id: id)
    }
    
    public func fetchOutGoing() async throws -> [OutGoingResponse] {
        try await dataSource.fetchOutGoing()
    }
}
