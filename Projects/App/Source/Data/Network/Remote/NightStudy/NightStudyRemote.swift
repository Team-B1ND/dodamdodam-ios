//
//  NightStudyRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct NightStudyRemote: RemoteProtocol {
    
    typealias Target = NightStudyService
    
    func postNightStudy(_ request: PostNightStudyRequest) async throws -> DefaultResponse {
        try await self.request(target: .postNightStudy(request))
            .map(DefaultResponse.self, using: decoder)
    }
    
    func deleteNightStudy(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .deleteNightStudy(id: id))
            .map(DefaultResponse.self, using: decoder)
    }
    
    func fetchNightStudy() async throws -> Response<NightStudyResponse> {
        try await self.request(target: .fetchNightStudy)
            .map(Response<NightStudyResponse>.self, using: decoder)
    }
}
