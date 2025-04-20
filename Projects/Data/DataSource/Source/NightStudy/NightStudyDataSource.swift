//
//  NightStudyDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import Network

public struct NightStudyDataSource: DataSourceProtocol {
    let remote: NightStudyRemote
    
    public init(remote: NightStudyRemote) {
        self.remote = remote
    }
    
    public func postNightStudy(_ request: PostNightStudyRequest) async throws -> DefaultResponse {
        try await remote.postNightStudy(request)
    }
    
    public func deleteNightStudy(id: Int) async throws {
        _ = try await remote.deleteNightStudy(id: id)
    }
    
    public func fetchNightStudy() async throws -> [NightStudyResponse] {
        let response = try await remote.fetchNightStudy()
        return response.data
    }
    
    public func checkBanStatus() async throws -> DefaultResponse {
        try await remote.checkBanStatus()
    }
}
