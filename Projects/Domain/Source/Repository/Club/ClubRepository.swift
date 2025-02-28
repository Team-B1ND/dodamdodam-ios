//
//  ClubRepository.swift
//  Domain
//
//  Created by dgsw30 on 2/25/25.
//

public protocol ClubRepository: RepositoryProtocol {
    
    func fetchClubs() async throws -> [ClubsResponse]
    
    func fetchClubMembers(id: Int) async throws -> [ClubMembersResponse]
    
    func fetchAllClubMembers(id: Int) async throws -> [ClubAllMembersResponse]

    func fetchClubDetail(id: Int) async throws -> ClubDetailResponse
    
    func fetchClubJoinRequests() async throws -> [ClubJoinRequestsResponse]
    
    func acceptJoinRequest(id: Int) async throws -> ClubJoinRequestsResponse
        
    func rejectJoinRequest(id: Int) async throws -> ClubJoinRequestsResponse
}
