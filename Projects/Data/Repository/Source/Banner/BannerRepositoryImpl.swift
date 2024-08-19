//
//  BannerRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import DataSource
import SwiftBok

@Init()
public struct BannerRepositoryImpl: BannerRepository {
    
    let dataSource: BannerDataSource
    
    public func fetchActiveBanner() async throws -> [BannerResponse] {
        try await dataSource.fetchActiveBanner()
    }
}
