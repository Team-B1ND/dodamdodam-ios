//
//  PointDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//
import Domain
import Network

public struct PointDataSource: DataSourceProtocol {
    let remote: PointRemote
    
    public init(remote: PointRemote) {
        self.remote = remote
    }
    
    public func fetchPoint(_ request: FetchPointRequest) async throws -> [PointResponse] {
        let response = try await remote.fetchPoint(request)
        return response.data
    }
    
    public func fetchPointScore(_ request: FetchPointScoreRequest) async throws -> PointScoreResponse {
        let response = try await remote.fetchPointScore(request)
        return response.data
    }
}
