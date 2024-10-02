//
//  MemberDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import Network

public struct MemberDataSource: DataSourceProtocol {
    let remote: MemberRemote
    
    public init(remote: MemberRemote) {
        self.remote = remote
    }
    
    public func postJoin(_ request: PostJoinRequest) async throws {
        _ = try await remote.postJoin(request)
    }
    
    public func patchDeactivate() async throws {
        _ = try await remote.patchDeactivate()
    }
    
    public func patchPassword(_ request: PatchPasswordRequest) async throws {
        _ = try await remote.patchPassword(request)
    }
    
    public func patchMemberInfo(_ request: PatchMemberInfoRequest) async throws {
        _ = try await remote.patchMemberInfo(request)
    }
    
    public func patchStudentInfo(_ request: PatchStudentInfoRequest) async throws {
        _ = try await remote.patchStudentInfo(request)
    }
    
    public func fetchInfo() async throws -> MemberResponse {
        let response = try await remote.fetchInfo()
        return response.data
    }
}
