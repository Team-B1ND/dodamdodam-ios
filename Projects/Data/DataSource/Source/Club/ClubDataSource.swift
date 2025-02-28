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
    
    public func fetchClubMembers(id: Int) async throws -> [ClubMembersResponse] {
        let response = try await remote.fetchClubMembers(id: id)
        return response.data
    }
    
    public func fetchAllClubMembers(id: Int) async throws -> [ClubAllMembersResponse] {
        let response = try await remote.fetchAllClubMembers(id: id)
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
}
