//
//  MemberRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct MemberRemote: RemoteProtocol {
    
    typealias Target = MemberService
    
    func postJoin(_ request: PostJoinRequest) async throws -> DefaultResponse {
        try await self.request(target: .postJoin(request))
    }
    
    func patchDeactivate() async throws -> DefaultResponse {
        try await self.request(target: .patchDeactivate)
    }
    
    func patchPassword(_ request: PatchPasswordRequest) async throws -> DefaultResponse {
        try await self.request(target: .patchPassword(request))
    }
    
    func patchMemberInfo(_ request: PatchMemberInfoRequest) async throws -> DefaultResponse {
        try await self.request(target: .patchMemberInfo(request))
    }
    
    func patchStudentInfo(_ request: PatchStudentInfoRequest) async throws -> DefaultResponse {
        try await self.request(target: .patchStudentInfo(request))
    }
    
    func fetchInfo() async throws -> Response<MemberResponse> {
        try await self.request(target: .fetchInfo, res: MemberResponse.self)
    }
}
