//
//  BannerRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import SwiftBok

@Init()
public struct BannerRemote: RemoteProtocol {
    
    typealias Target = BannerService
    
    public func fetchActiveBanner() async throws -> Response<[BannerResponse]> {
        try await self.request(target: .fetchActiveBanner, res: [BannerResponse].self)
    }
}
