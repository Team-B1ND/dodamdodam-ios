//
//  PointRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation

struct PointRemote: RemoteProtocol {
    
    typealias Target = PointService
    
    func fetchPoint(_ request: FetchPointRequest) async throws -> Response<[PointResponse]> {
        try await self.request(target: .fetchPoint(request))
            .map(Response<[PointResponse]>.self, using: decoder)
    }
    
    func fetchPointScore(_ request: FetchPointScoreRequest) async throws -> Response<[PointScoreResponse]> {
        try await self.request(target: .fetchPointScore(request))
            .map(Response<[PointScoreResponse]>.self, using: decoder)
    }
}
