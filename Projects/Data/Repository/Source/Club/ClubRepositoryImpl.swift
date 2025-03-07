//
//  ClubRepositoryImpl.swift
//  Repository
//
//  Created by dgsw30 on 2/25/25.
//

import Domain
import DataSource

public struct ClubRepositoryImpl: ClubRepository {
    let dataSource: ClubDataSource
    
    public init(dataSource: ClubDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchClubs() async throws -> [ClubsResponse] {
        return try await dataSource.fetchClubs()
    }
    
    public func fetchCreativeClubs() async throws -> [ClubsResponse] {
        return try await dataSource.fetchCreativeClubs()
    }
    
    public func fetchFreeClubs() async throws -> [ClubsResponse] {
        return try await dataSource.fetchFreeClubs()
    }
    
    public func fetchClubMembers(id: Int) async throws -> ClubMembersInfoResponse {
        return try await dataSource.fetchClubMembers(id: id)
    }
    
    public func fetchClubDetail(id: Int) async throws -> ClubDetailResponse {
        return try await dataSource.fetchClubDetail(id: id)
    }
    
    public func fetchClubJoinRequests() async throws -> [ClubJoinRequestsResponse] {
        return try await dataSource.fetchClubJoinRequests()
    }
    
    public func acceptJoinRequest(id: Int) async throws -> ClubJoinRequestsResponse {
        return try await dataSource.acceptJoinRequest(id: id)
    }
    
    public func rejectJoinRequest(id: Int) async throws -> ClubJoinRequestsResponse {
        return try await dataSource.rejectJoinRequest(id: id)
    }
    
    public func applyToClub(request: [ClubApplyRequest]) async throws {
        return try await dataSource.applyToClub(request: request)
    }
    
    public func fetchJoinedClubs() async throws -> [JoinedClubResponse] {
        return try await dataSource.fetchJoinedClubs()
    }
    
    public func fetchMyClubs() async throws -> [MyClubResponse] {
        return try await dataSource.fetchMyClubs()
    }
    
    public func fetchMyApplyClubs() async throws -> [MyApplyClubResponse] {
        return try await dataSource.fetchMyApplyClubs()
    }
}
