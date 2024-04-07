//
//  BannerRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct BannerRepositoryImpl: BannerRepository {
    
    let dataSource: BannerDataSource
    
    func fetchActiveBanner() async throws -> [BannerResponse] {
        try await dataSource.fetchActiveBanner()
    }
}
