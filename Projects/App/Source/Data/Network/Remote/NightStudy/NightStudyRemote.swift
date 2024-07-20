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
    }
    
    func deleteNightStudy(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .deleteNightStudy(id: id))
    }
    
    func fetchNightStudy() async throws -> Response<[NightStudyResponse]> {
        try await self.request(target: .fetchNightStudy, res: [NightStudyResponse].self)
    }
}
