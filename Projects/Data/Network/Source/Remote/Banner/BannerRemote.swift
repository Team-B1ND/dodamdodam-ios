//
//  BannerRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain

public struct BannerRemote: RemoteProtocol {
    
    typealias Target = BannerService
    
    public init() {}
    
    public func fetchActiveBanner() async throws -> Response<[BannerResponse]> {
        try await self.request(target: .fetchActiveBanner, res: [BannerResponse].self)
    }
}
