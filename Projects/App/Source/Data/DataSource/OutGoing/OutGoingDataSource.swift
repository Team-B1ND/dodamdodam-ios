//
//  OutGoingDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct OutGoingDataSource: DataSourceProtocol {
    
    let remote: OutGoingRemote
    
    func postOutGoing(_ request: PostOutGoingRequest) async throws {
        _ = try await remote.postOutGoing(request)
    }
    
    func deleteOutGoing(id: Int) async throws {
        _ = try await remote.deleteOutGoing(id: id)
    }
    
    func fetchOutGoing() async throws -> [OutGoingResponse] {
        let response = try await remote.fetchOutGoing()
        return response.data
    }
}
