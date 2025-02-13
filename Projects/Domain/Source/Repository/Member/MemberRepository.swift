//
//  MemberRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

public protocol MemberRepository: RepositoryProtocol {
    
    func postStudentJoin(_ request: PostJoinStudentRequest) async throws
    
    func postParentJoin(_ request: PostJoinParentRequest) async throws
    
    func postAuthCode(type: AuthType, _ request: PostAuthCodeRequest) async throws
    
    func postVerifyAuthCode(type: AuthType, _ request: PostVerifyAuthCodeRequest) async throws
    
    func patchDeactivate() async throws
    
    func patchPassword(_ request: PatchPasswordRequest) async throws
    
    func patchMemberInfo(_ request: PatchMemberInfoRequest) async throws
    
    func patchStudentInfo(_ request: PatchStudentInfoRequest) async throws
    
    func fetchInfo() async throws -> MemberResponse
}
