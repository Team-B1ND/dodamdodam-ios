//
//  PointRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct PointRemote: RemoteProtocol {
    
    typealias Target = PointService
    
    func fetchPoint(_ request: FetchPointRequest) async throws -> Response<[PointResponse]> {
        try await self.request(target: .fetchPoint(request), res: [PointResponse].self)
    }
    
    func fetchPointScore(_ request: FetchPointScoreRequest) async throws -> Response<PointScoreResponse> {
        try await self.request(target: .fetchPointScore(request), res: PointScoreResponse.self)
    }
}
