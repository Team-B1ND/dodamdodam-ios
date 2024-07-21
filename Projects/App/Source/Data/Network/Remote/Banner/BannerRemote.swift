//
//  BannerRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct BannerRemote: RemoteProtocol {
    
    typealias Target = BannerService
    
    func fetchActiveBanner() async throws -> Response<[BannerResponse]> {
        try await self.request(target: .fetchActiveBanner, res: [BannerResponse].self)
    }
}
