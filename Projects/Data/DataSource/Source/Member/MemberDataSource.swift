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
    
    public func postStudentJoin(_ request: PostJoinStudentRequest) async throws {
        _ = try await remote.postStudentJoin(request)
    }
    
    public func postParentJoin(_ request: PostJoinParentRequest) async throws {
        _ = try await remote.postParentJoin(request)
    }
    
    public func postAuthCode(type: AuthType, _ request: PostAuthCodeRequest) async throws {
        _ = try await remote.postAuthCode(type: type, request: request)
    }
    
    public func postVerifyAuthCode(type: AuthType, _ request: PostVerifyAuthCodeRequest) async throws {
        _ = try await remote.postVerifyAuthCode(type: type, request: request)
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
    
    public func fetchMemberByCode(code: String) async throws -> MemberResponse {
        let response = try await remote.fetchMemberByCode(code: code)
        return response.data
    }
}
