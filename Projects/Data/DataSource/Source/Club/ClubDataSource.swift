//
//  ClubDataSource.swift
//  Repository
//
//  Created by dgsw30 on 2/25/25.
//

import Domain
import Network

public struct ClubDataSource: DataSourceProtocol {
    let remote: ClubRemote
    
    public init(remote: ClubRemote) {
        self.remote = remote
    }
    
    public func fetchClubs() async throws -> [ClubsResponse] {
        let response = try await remote.fetchClubs()
        return response.data
    }
    
    public func fetchCreativeClubs() async throws -> [ClubsResponse] {
        let response = try await remote.fetchCreativeClubs()
        return response.data
    }
    
    public func fetchFreeClubs() async throws -> [ClubsResponse] {
        let response = try await remote.fetchFreeClubs()
        return response.data
    }
    
    public func fetchClubMembers(id: Int) async throws -> ClubMembersInfoResponse {
        let response = try await remote.fetchClubMembers(id: id)
        return response.data
    }
    
    public func fetchClubDetail(id: Int) async throws -> ClubDetailResponse {
        let response = try await remote.fetchClubDetail(id: id)
        return response.data
    }
    
    public func fetchClubJoinRequests() async throws -> [ClubJoinRequestsResponse] {
        let response = try await remote.fetchClubJoinRequests()
        return response.data
    }
    
    public func acceptJoinRequest(id: Int) async throws -> ClubJoinRequestsResponse {
        let response = try await remote.acceptJoinRequest(id: id)
        return response.data
    }
    
    public func rejectJoinRequest(id: Int) async throws -> ClubJoinRequestsResponse {
        let response = try await remote.rejectJoinRequest(id: id)
        return response.data
    }
    
    public func applyToClub(request: [ClubApplyRequest]) async throws {
        _ = try await remote.applyToClub(request: request)
    }
    
    public func fetchJoinedClubs() async throws -> [JoinedClubResponse] {
        let response = try await remote.fetchJoinedClubs()
        return response.data
    }
    
    public func fetchMyClubs() async throws -> [MyClubResponse] {
        let response = try await remote.fetchMyClubs()
        return response.data
    }
    
    public func fetchMyApplyClubs() async throws -> [MyApplyClubResponse] {
        let response = try await remote.fetchMyApplyClubs()
        return response.data
    }
    
    public func fetchClubRegisterTime() async throws -> ClubRegisterTimeResponse {
        let response = try await remote.fetchClubRegisterTime()
        return response.data
    }
}
