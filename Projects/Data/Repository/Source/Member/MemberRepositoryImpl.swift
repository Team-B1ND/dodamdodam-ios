//
//  MemberRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import DataSource

public struct MemberRepositoryImpl: MemberRepository {
    
    let dataSource: MemberDataSource
    
    public init(dataSource: MemberDataSource) {
        self.dataSource = dataSource
    }
    
    public func postStudentJoin(_ request: PostJoinStudentRequest) async throws {
        try await dataSource.postStudentJoin(request)
    }
    
    public func postParentJoin(_ request: PostJoinParentRequest) async throws {
        try await dataSource.postParentJoin(request)
    }
    
    public func postAuthCode(type: AuthType, _ request: PostAuthCodeRequest) async throws {
        try await dataSource.postAuthCode(type: type, request)
    }
    
    public func postVerifyAuthCode(type: AuthType, _ request: PostVerifyAuthCodeRequest) async throws {
        try await dataSource.postVerifyAuthCode(type: type, request)
    }
    
    public func postRelation(_ request: PostRelationRequest) async throws {
        try await dataSource.postRelation(request)
    }
    
    public func patchDeactivate() async throws {
        try await dataSource.patchDeactivate()
    }
    
    public func patchPassword(_ request: PatchPasswordRequest) async throws {
        try await dataSource.patchPassword(request)
    }
    
    public func patchMemberInfo(_ request: PatchMemberInfoRequest) async throws {
        try await dataSource.patchMemberInfo(request)
    }
    
    public func patchStudentInfo(_ request: PatchStudentInfoRequest) async throws {
        try await dataSource.patchStudentInfo(request)
    }
    
    public func fetchInfo() async throws -> MemberResponse {
        try await dataSource.fetchInfo()
    }
    
    public func fetchMemberByCode(code: String) async throws -> MemberResponse {
        try await dataSource.fetchMemberByCode(code: code)
    }
    
    public func fetchRelation() async throws -> [ConnectStudentResponse] {
        try await dataSource.fetchRelation()
    }
    
    public func checkNightStudyManager() async throws -> Bool {
        try await dataSource.checkNightStudyManager()
    }
}
