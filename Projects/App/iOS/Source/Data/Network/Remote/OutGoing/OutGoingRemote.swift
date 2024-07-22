//
//  OutGoingRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct OutGoingRemote: RemoteProtocol {
    
    typealias Target = OutGoingService
    
    func postOutGoing(_ request: PostOutGoingRequest) async throws -> DefaultResponse {
        try await self.request(target: .postOutGoing(request))
    }
    
    func deleteOutGoing(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .deleteOutGoing(id: id))
    }
    
    func fetchOutGoing() async throws -> Response<[OutGoingResponse]> {
        try await self.request(target: .fetchOutGoing, res: [OutGoingResponse].self)
    }
}
