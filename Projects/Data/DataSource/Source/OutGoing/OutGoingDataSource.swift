//
//  OutGoingDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import Network
import SwiftBok

@Init()
public struct OutGoingDataSource: DataSourceProtocol {
    
    let remote: OutGoingRemote
    
    public func postOutGoing(_ request: PostOutGoingRequest) async throws {
        _ = try await remote.postOutGoing(request)
    }
    
    public func deleteOutGoing(id: Int) async throws {
        _ = try await remote.deleteOutGoing(id: id)
    }
    
    public func fetchOutGoing() async throws -> [OutGoingResponse] {
        let response = try await remote.fetchOutGoing()
        return response.data
    }
}
