//
//  OutSleepingRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct OutSleepingRemote: RemoteProtocol {
    
    typealias Target = OutSleepingService
    
    func postOutSleeping(_ request: PostOutSleepingRequest) async throws -> DefaultResponse {
        try await self.request(target: .postOutSleeping(request))
            .map(DefaultResponse.self, using: decoder)
    }
    
    func deleteOutSleeping(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .deleteOutSleeping(id: id))
            .map(DefaultResponse.self, using: decoder)
    }
    
    func fetchOutSleeping() async throws -> Response<[OutSleepingResponse]> {
        try await self.request(target: .fetchOutSleeping)
            .map(Response<[OutSleepingResponse]>.self, using: decoder)
    }
}
