//
//  MemberDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct MemberDataSource: DataSourceProtocol {
    
    let remote: MemberRemote
    
    func postJoin(_ request: PostJoinRequest) async throws {
        _ = try await remote.postJoin(request)
    }
    
    func patchPassword(_ request: PatchPasswordRequest) async throws {
        _ = try await remote.patchPassword(request)
    }
    
    func patchMemberInfo(_ request: PatchMemberInfoRequest) async throws {
        _ = try await remote.patchMemberInfo(request)
    }
    
    func patchStudentInfo(_ request: PatchStudentInfoRequest) async throws {
        _ = try await remote.patchStudentInfo(request)
    }
    
    func fetchInfo() async throws -> MemberResponse {
        let response = try await remote.fetchInfo()
        return response.data
    }
}
