//
//  OutGoingRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct OutGoingRepositoryImpl: OutGoingRepository {
    
    let dataSource: OutGoingDataSource
    
    func postOutGoing(_ request: PostOutGoingRequest) async throws {
        try await dataSource.postOutGoing(request)
    }
    
    func deleteOutGoing(id: Int) async throws {
        try await dataSource.deleteOutGoing(id: id)
    }
    
    func fetchOutGoing() async throws -> [OutGoingResponse] {
        try await dataSource.fetchOutGoing()
    }
}
