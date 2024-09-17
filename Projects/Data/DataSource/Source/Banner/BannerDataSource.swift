//
//  BannerDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Network
import Domain

public struct BannerDataSource: DataSourceProtocol {
    
    let remote: BannerRemote
    
    public init(remote: BannerRemote) {
        self.remote = remote
    }
    
    public func fetchActiveBanner() async throws -> [BannerResponse] {
        let response = try await remote.fetchActiveBanner()
        return response.data
    }
}
