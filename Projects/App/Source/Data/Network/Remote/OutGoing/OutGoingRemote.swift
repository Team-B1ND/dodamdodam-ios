//
//  OutGoingRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation

struct OutGoingRemote: RemoteProtocol {
    
    typealias Target = OutGoingService
    
    func postOutGoing(_ request: PostOutGoingRequest) async throws -> DefaultResponse {
        try await self.request(target: .postOutGoing(request))
            .map(DefaultResponse.self, using: decoder)
    }
    
    func deleteOutGoing(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .deleteOutGoing(id: id))
            .map(DefaultResponse.self, using: decoder)
    }
    
    func fetchOutGoing() async throws -> Response<[OutGoingResponse]> {
        try await self.request(target: .fetchOutGoing)
            .map(Response<[OutGoingResponse]>.self, using: decoder)
    }
}
