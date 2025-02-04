//
//  DivisionRepositoryImpl.swift
//  Repository
//
//  Created by hhhello0507 on 2/4/25.
//

import Domain
import DataSource

public struct DivisionRepositoryImpl: DivisionRepository {
    let dataSource: DivisionDataSource
    
    public func createDivision(_ request: PostDivisionRequest) async throws {
        try await dataSource.createDivision(request)
    }
    
    public func applyMemberDivision(id: Int) async throws {
        try await dataSource.applyMemberDivision(id: id)
    }
    
    public func addMembers(id: Int, request: AddMembersRequest) async throws {
        try await dataSource.addMembers(id: id, request: request)
    }
    
    public func patchDivision(_ request: PostDivisionRequest) async throws {
        try await dataSource.patchDivision(request)
    }
    
    public func patchMemberStatus(id: Int, _ request: PatchMembersStatusRequest) async throws {
        try await dataSource.patchMemberStatus(id: id, request)
    }
    
    public func deleteDivision(id: Int) async throws {
        try await dataSource.deleteDivision(id: id)
    }
    
    public func deleteMembers(id: Int, _ request: DeleteDivisionMembersRequest) async throws {
        try await dataSource.deleteMembers(id: id, request)
    }
    
    public func fetchDivisions(_ request: FetchDivisionRequest) async throws -> [DivisionOverviewResponse] {
        return try await dataSource.fetchDivisions(request)
    }
    
    public func fetchDivision(id: Int) async throws -> DivisionDetailResponse {
        return try await dataSource.fetchDivision(id: id)
    }
    
    public func fetchMyDivision(_ request: FetchDivisionRequest) async throws -> [DivisionOverviewResponse] {
        return try await dataSource.fetchMyDivision(request)
    }
    
    public func fetchDivisionMembers(id: Int, _ request: FetchDivisionMembersRequest) async throws -> [DivisionMemberResponse] {
        return try await dataSource.fetchDivisionMembers(id: id, request)
    }
    
    public func fetchDivisionMembersCount(id: Int, _ request: FetchDivisionMembersRequest) async throws -> DivisionMembersCountResponse {
        return try await dataSource.fetchDivisionMembersCount(id: id, request)
    }
}
