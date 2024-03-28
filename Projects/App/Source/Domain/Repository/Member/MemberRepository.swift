//
//  MemberRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

protocol MemberRepository: RepositoryProtocol {
    
    func postJoin(_ request: PostJoinRequest) async throws
    
    func patchPassword(_ request: PatchPasswordRequest) async throws
    
    func patchMemberInfo(_ request: PatchMemberInfoRequest) async throws
    
    func patchStudentInfo(_ request: PatchStudentInfoRequest) async throws
    
    func fetchInfo() async throws -> MemberResponse
}
