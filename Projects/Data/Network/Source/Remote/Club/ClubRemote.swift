//
//  ClubRemote.swift
//  Repository
//
//  Created by dgsw30 on 2/25/25.
//

import Domain

public struct ClubRemote: RemoteProtocol {
    
    typealias Target = ClubService
    
    public init() {}
    
    public func fetchClubs() async throws -> Response<[ClubsResponse]> {
        try await self.request(target: .fetchClub, res: [ClubsResponse].self)
    }
    
    public func fetchClubMembers(id: Int) async throws -> Response<[ClubMembersResponse]> {
        try await self.request(target: .fetchClubMembers(id: id), res: [ClubMembersResponse].self)
    }
    
    public func fetchAllClubMembers(id: Int) async throws -> Response<[ClubAllMembersResponse]> {
        try await self.request(target: .fetchAllClubMembers(id: id), res: [ClubAllMembersResponse].self)
    }
    
    public func fetchClubDetail(id: Int) async throws -> Response<ClubDetailResponse> {
        try await self.request(target: .fetchClubDetail(id: id), res: ClubDetailResponse.self)
    }
    
    public func fetchClubJoinRequests() async throws -> Response<[ClubJoinRequestsResponse]> {
        try await self.request(target: .fetchClubJoinRequests, res: [ClubJoinRequestsResponse].self)
    }
}
