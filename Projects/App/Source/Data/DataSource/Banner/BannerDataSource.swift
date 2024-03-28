//
//  BannerDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct BannerDataSource: DataSourceProtocol {
    
    let remote: BannerRemote
    
    func fetchActiveBanner() async throws -> BannerResponse {
        let response = try await remote.fetchActiveBanner()
        return response.data
    }
}
