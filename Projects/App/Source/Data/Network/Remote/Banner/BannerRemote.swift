//
//  BannerRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation

struct BannerRemote: RemoteProtocol {
    
    typealias Target = BannerService
    
    func fetchActiveBanner() async throws -> Response<BannerResponse> {
        try await self.request(target: .fetchActiveBanner)
            .map(Response<BannerResponse>.self, using: decoder)
    }
}
