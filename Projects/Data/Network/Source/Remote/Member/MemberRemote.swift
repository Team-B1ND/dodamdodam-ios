//
//  MemberRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain

public struct MemberRemote: RemoteProtocol {
    
    typealias Target = MemberService
    
    public init() {}
    
    public func postStudentJoin(_ request: PostJoinStudentRequest) async throws -> DefaultResponse {
        try await self.request(target: .postJoinStudent(request))
    }
    
    public func postParentJoin(_ request: PostJoinParentRequest) async throws -> DefaultResponse {
        try await self.request(target: .postJoinParent(request))
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
