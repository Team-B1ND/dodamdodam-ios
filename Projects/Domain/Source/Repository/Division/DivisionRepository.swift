//
//  DivisionRepository.swift
//  Domain
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation

public protocol DivisionRepository: RepositoryProtocol {
    
    func createDivision(_ request: PostDivisionRequest) async throws
    
    func applyMemberDivision(id: Int) async throws
    
    func addMembers(id: Int, request: AddMembersRequest) async throws
    
    func patchDivision(_ request: PostDivisionRequest) async throws
    
    func patchMemberStatus(id: Int, _ request: PatchMembersStatusRequest) async throws
    
    func patchMemberPermission(id: Int, divisionMemberId: Int, _ request: PatchMemberPermissionRequest) async throws
    
    func deleteDivision(id: Int) async throws
    
    func deleteMembers(id: Int, _ request: DeleteDivisionMembersRequest) async throws
    
    func fetchDivisions(_ request: FetchDivisionRequest) async throws -> [DivisionOverviewResponse]
    
    func fetchDivision(id: Int) async throws -> DivisionDetailResponse
    
    func fetchMyDivision(_ request: FetchDivisionRequest) async throws -> [DivisionOverviewResponse]
    
    func fetchDivisionMembers(id: Int, _ request: FetchDivisionMembersRequest) async throws -> [DivisionMemberResponse]
    
    func fetchDivisionMembersCount(id: Int, _ request: FetchDivisionMembersRequest) async throws -> DivisionMembersCountResponse
}
