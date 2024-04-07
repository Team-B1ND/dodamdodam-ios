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
            .map(DefaultResponse.self, using: decoder)
    }
    
    func patchDeactivate() async throws -> DefaultResponse {
        try await self.request(target: .patchDeactivate)
            .map(DefaultResponse.self, using: decoder)
    }
    
    func patchPassword(_ request: PatchPasswordRequest) async throws -> DefaultResponse {
        try await self.request(target: .patchPassword(request))
            .map(DefaultResponse.self, using: decoder)
    }
    
    func patchMemberInfo(_ request: PatchMemberInfoRequest) async throws -> DefaultResponse {
        try await self.request(target: .patchMemberInfo(request))
            .map(DefaultResponse.self, using: decoder)
    }
    
    func patchStudentInfo(_ request: PatchStudentInfoRequest) async throws -> DefaultResponse {
        try await self.request(target: .patchStudentInfo(request))
            .map(DefaultResponse.self, using: decoder)
    }
    
    func fetchInfo() async throws -> Response<MemberResponse> {
        try await self.request(target: .fetchInfo)
            .map(Response<MemberResponse>.self, using: decoder)
    }
}
