//
//  MemberRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct MemberRepositoryImpl: MemberRepository {
    
    let dataSource: MemberDataSource
    
    func postJoin(_ request: PostJoinRequest) async throws {
        try await dataSource.postJoin(request)
    }
    
    func patchPassword(_ request: PatchPasswordRequest) async throws {
        try await dataSource.patchPassword(request)
    }
    
    func patchMemberInfo(_ request: PatchMemberInfoRequest) async throws {
        try await dataSource.patchMemberInfo(request)
    }
    
    func patchStudentInfo(_ request: PatchStudentInfoRequest) async throws {
        try await dataSource.patchStudentInfo(request)
    }
    
    func fetchInfo() async throws -> MemberResponse {
        try await dataSource.fetchInfo()
    }
}
