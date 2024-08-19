//
//  OutGoingRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import SwiftBok

@Init()
public struct OutGoingRemote: RemoteProtocol {
    
    typealias Target = OutGoingService
    
    public func postOutGoing(_ request: PostOutGoingRequest) async throws -> DefaultResponse {
        try await self.request(target: .postOutGoing(request))
    }
    
    public func deleteOutGoing(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .deleteOutGoing(id: id))
    }
    
    public func fetchOutGoing() async throws -> Response<[OutGoingResponse]> {
        try await self.request(target: .fetchOutGoing, res: [OutGoingResponse].self)
    }
}
