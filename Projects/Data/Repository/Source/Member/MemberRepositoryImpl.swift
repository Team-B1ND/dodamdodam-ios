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
    
    public func postJoin(_ request: PostJoinRequest) async throws {
        try await dataSource.postJoin(request)
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
}
