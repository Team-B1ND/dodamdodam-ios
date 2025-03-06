//
//  DivisionRemote.swift
//
//  Created by hhhello0507 on 2/4/25.
//

import Domain

public struct DivisionRemote: RemoteProtocol {
    
    typealias Target = DivisionService
    
    public init() {}
    
    public func createDivision(_ request: PostDivisionRequest) async throws -> DefaultResponse {
        try await self.request(target: .createDivision(request))
    }
    
    public func applyMemberDivision(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .applyMemberDivision(id: id))
    }
    
    public func addMembers(id: Int, request: AddMembersRequest) async throws -> DefaultResponse {
        try await self.request(target: .addMembers(id: id, request: request))
    }
    
    public func patchDivision(_ request: PostDivisionRequest) async throws -> DefaultResponse {
        try await self.request(target: .patchDivision(request))
    }
    
    public func patchMemberStatus(id: Int, _ request: PatchMembersStatusRequest) async throws -> DefaultResponse {
        try await self.request(target: .patchMemberStatus(id: id, request: request))
    }
    
    public func patchMemberPermission(id: Int, divisionMemberId: Int, _ request: PatchMemberPermissionRequest) async throws -> DefaultResponse {
        try await self.request(target: .patchMemberPermission(id: id, divisionMemberId: divisionMemberId, request: request))
    }
    
    public func deleteDivision(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .deleteDivision(id: id))
    }
    
    public func deleteMembers(id: Int, _ request: DeleteDivisionMembersRequest) async throws -> DefaultResponse {
        try await self.request(target: .deleteMembers(id: id, request: request))
    }
    
    public func fetchDivisions(_ request: FetchDivisionRequest) async throws -> Response<[DivisionOverviewResponse]> {
        try await self.request(target: .fetchDivisions(request: request), res: [DivisionOverviewResponse].self)
    }
    
    public func fetchDivision(id: Int) async throws -> Response<DivisionDetailResponse> {
        try await self.request(target: .fetchDivision(id: id), res: DivisionDetailResponse.self)
    }
    
    public func fetchMyDivision(_ request: FetchDivisionRequest) async throws -> Response<[DivisionOverviewResponse]> {
        try await self.request(target: .fetchMyDivision(request: request), res: [DivisionOverviewResponse].self)
    }
    
    public func fetchDivisionMembers(id: Int, _ request: FetchDivisionMembersRequest) async throws -> Response<[DivisionMemberResponse]> {
        try await self.request(target: .fetchDivisionMembers(id: id, request: request), res: [DivisionMemberResponse].self)
    }
    
    public func fetchDivisionMembersCount(id: Int, _ request: FetchDivisionMembersRequest) async throws -> Response<DivisionMembersCountResponse> {
        try await self.request(target: .fetchDivisionMembersCount(id: id, request: request), res: DivisionMembersCountResponse.self)
    }
}
