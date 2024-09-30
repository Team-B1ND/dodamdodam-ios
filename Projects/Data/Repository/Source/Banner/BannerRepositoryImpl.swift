//
//  BannerRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import DataSource

public struct BannerRepositoryImpl: BannerRepository {
    
    let dataSource: BannerDataSource
    
    public init(dataSource: BannerDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchActiveBanner() async throws -> [BannerResponse] {
        try await dataSource.fetchActiveBanner()
    }
}
