//
//  MemberRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import SwiftBok

@Init()
public struct MemberRemote: RemoteProtocol {
    
    typealias Target = MemberService
    
    public func postJoin(_ request: PostJoinRequest) async throws -> DefaultResponse {
        try await self.request(target: .postJoin(request))
    }
    
    public func patchDeactivate() async throws -> DefaultResponse {
        try await self.request(target: .patchDeactivate)
    }
    
    public func patchPassword(_ request: PatchPasswordRequest) async throws -> DefaultResponse {
        try await self.request(target: .patchPassword(request))
    }
    
    public func patchMemberInfo(_ request: PatchMemberInfoRequest) async throws -> DefaultResponse {
        try await self.request(target: .patchMemberInfo(request))
    }
    
    public func patchStudentInfo(_ request: PatchStudentInfoRequest) async throws -> DefaultResponse {
        try await self.request(target: .patchStudentInfo(request))
    }
    
    public func fetchInfo() async throws -> Response<MemberResponse> {
        try await self.request(target: .fetchInfo, res: MemberResponse.self)
    }
}
