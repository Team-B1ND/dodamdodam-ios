//
//  DivisionDataSource.swift
//  Repository
//
//  Created by hhhello0507 on 2/4/25.
//

import Network
import Domain

public struct DivisionDataSource: DataSourceProtocol {
    let remote: DivisionRemote
    
    public init(remote: DivisionRemote) {
        self.remote = remote
    }
    
    public func createDivision(_ request: PostDivisionRequest) async throws {
        _ = try await self.remote.createDivision(request)
    }
    
    public func applyMemberDivision(id: Int) async throws {
        _ = try await self.remote.applyMemberDivision(id: id)
    }
    
    public func addMembers(id: Int, request: AddMembersRequest) async throws {
        _ = try await self.remote.addMembers(id: id, request: request)
    }
    
    public func patchDivision(_ request: PostDivisionRequest) async throws {
        _ = try await self.remote.patchDivision(request)
    }
    
    public func patchMemberStatus(id: Int, _ request: PatchMembersStatusRequest) async throws {
        _ = try await self.remote.patchMemberStatus(id: id, request)
    }
    
    public func deleteDivision(id: Int) async throws {
        _ = try await self.remote.deleteDivision(id: id)
    }
    
    public func deleteMembers(id: Int, _ request: DeleteDivisionMembersRequest) async throws {
        _ = try await self.remote.deleteMembers(id: id, request)
    }
    
    public func fetchDivisions(_ request: FetchDivisionRequest) async throws -> [DivisionOverviewResponse] {
        let response = try await self.remote.fetchDivisions(request)
        return response.data
    }
    
    public func fetchDivision(id: Int) async throws -> DivisionDetailResponse {
        let response = try await self.remote.fetchDivision(id: id)
        return response.data
    }
    
    public func fetchMyDivision(_ request: FetchDivisionRequest) async throws -> [DivisionOverviewResponse] {
        let response = try await self.remote.fetchMyDivision(request)
        return response.data
    }
    
    public func fetchDivisionMembers(id: Int, _ request: FetchDivisionMembersRequest) async throws -> [DivisionMemberResponse] {
        let response = try await self.remote.fetchDivisionMembers(id: id, request)
        return response.data
    }
    
    public func fetchDivisionMembersCount(id: Int, _ request: FetchDivisionMembersRequest) async throws -> DivisionMembersCountResponse {
        let response = try await self.remote.fetchDivisionMembersCount(id: id, request)
        return response.data
    }
}
