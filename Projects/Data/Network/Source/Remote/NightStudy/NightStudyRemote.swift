//
//  NightStudyRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain

public struct NightStudyRemote: RemoteProtocol {
    
    typealias Target = NightStudyService
    
    public init() {}
    
    public func postNightStudy(_ request: PostNightStudyRequest) async throws -> DefaultResponse {
        try await self.request(target: .postNightStudy(request))
    }
    
    public func deleteNightStudy(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .deleteNightStudy(id: id))
    }
    
    public func fetchNightStudy() async throws -> Response<[NightStudyResponse]> {
        try await self.request(target: .fetchNightStudy, res: [NightStudyResponse].self)
    }
}
