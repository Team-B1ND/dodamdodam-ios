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
    
    public func postAuthCode(type: AuthType, request: PostAuthCodeRequest) async throws -> DefaultResponse {
        try await self.request(target: .postAuthCode(type: type, request))
    }
    
    public func postVerifyAuthCode(type: AuthType, request: PostVerifyAuthCodeRequest) async throws -> DefaultResponse {
        try await self.request(target: .postVerifyAuthCode(type: type, request))
    }
    
    public func postRelation(_ request: PostRelationRequest) async throws -> DefaultResponse {
        try await self.request(target: .postRelation(request))
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
    
    public func fetchMemberByCode(code: String) async throws -> Response<MemberResponse> {
        try await self.request(target: .fetchMemberByCode(code: code), res: MemberResponse.self)
    }
    
    public func fetchRelation() async throws -> Response<[ConnectStudentResponse]> {
        try await self.request(target: .fetchRelation, res: [ConnectStudentResponse].self)
    }
}
