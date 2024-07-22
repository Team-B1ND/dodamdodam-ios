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
    }
    
    func deleteOutSleeping(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .deleteOutSleeping(id: id))
    }
    
    func fetchOutSleeping() async throws -> Response<[OutSleepingResponse]> {
        try await self.request(target: .fetchOutSleeping, res: [OutSleepingResponse].self)
    }
}
