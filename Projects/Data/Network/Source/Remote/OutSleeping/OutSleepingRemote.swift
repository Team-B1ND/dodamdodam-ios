//
//  OutSleepingRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import SwiftBok

@Init()
public struct OutSleepingRemote: RemoteProtocol {
    
    typealias Target = OutSleepingService
    
    public func postOutSleeping(_ request: PostOutSleepingRequest) async throws -> DefaultResponse {
        try await self.request(target: .postOutSleeping(request))
    }
    
    public func deleteOutSleeping(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .deleteOutSleeping(id: id))
    }
    
    public func fetchOutSleeping() async throws -> Response<[OutSleepingResponse]> {
        try await self.request(target: .fetchOutSleeping, res: [OutSleepingResponse].self)
    }
}
