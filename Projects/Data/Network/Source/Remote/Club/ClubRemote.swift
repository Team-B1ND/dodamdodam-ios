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
    
    public func fetchCreativeClubs() async throws -> Response<[ClubsResponse]> {
        try await self.request(target: .fetchCreativeClubs, res: [ClubsResponse].self)
    }
    
    public func fetchFreeClubs() async throws -> Response<[ClubsResponse]> {
        try await self.request(target: .fetchFreeClubs, res: [ClubsResponse].self)
    }
    
    public func fetchClubMembers(id: Int) async throws -> Response<ClubMembersInfoResponse> {
        try await self.request(target: .fetchClubMembers(id: id), res: ClubMembersInfoResponse.self)
    }
    
    public func fetchClubDetail(id: Int) async throws -> Response<ClubDetailResponse> {
        try await self.request(target: .fetchClubDetail(id: id), res: ClubDetailResponse.self)
    }
    
    public func fetchClubJoinRequests() async throws -> Response<[ClubJoinRequestsResponse]> {
        try await self.request(target: .fetchClubJoinRequests, res: [ClubJoinRequestsResponse].self)
    }
    
    public func acceptJoinRequest(id: Int) async throws -> Response<ClubJoinRequestsResponse> {
        try await self.request(target: .acceptJoinRequest(id: id), res: ClubJoinRequestsResponse.self)
    }
    
    public func rejectJoinRequest(id: Int) async throws -> Response<ClubJoinRequestsResponse> {
        try await self.request(target: .rejectJoinRequest(id: id), res: ClubJoinRequestsResponse.self)
    }
    
    public func applyToClub(request: ClubApplyRequest) async throws -> Response<VoidResponse> {
        try await self.request(target: .applyToClub(request: request), res: VoidResponse.self)
    }
    
    public func fetchJoinedClubs() async throws -> Response<[JoinedClubResponse]> {
        try await self.request(target: .fetchJoinedClubs, res: [JoinedClubResponse].self)
    }
    
    public func fetchMyClubs() async throws -> Response<[MyClubResponse]> {
            try await self.request(target: .fetchMyClubs, res: [MyClubResponse].self)
        }
}
