//
//  ClubRepository.swift
//  Domain
//
//  Created by dgsw30 on 2/25/25.
//

public protocol ClubRepository: RepositoryProtocol {
    
    func fetchClubs() async throws -> [ClubsResponse]
    
    func fetchCreativeClubs() async throws -> [ClubsResponse]
    
    func fetchFreeClubs() async throws -> [ClubsResponse]
    
    func fetchClubMembers(id: Int) async throws -> ClubMembersInfoResponse
    
    func fetchClubDetail(id: Int) async throws -> ClubDetailResponse
    
    func fetchClubJoinRequests() async throws -> [ClubJoinRequestsResponse]
    
    func acceptJoinRequest(id: Int) async throws -> ClubJoinRequestsResponse
    
    func rejectJoinRequest(id: Int) async throws -> ClubJoinRequestsResponse
    
    func applyToClub(request: [ClubApplyRequest]) async throws
    
    func fetchJoinedClubs() async throws -> [JoinedClubResponse]
    
    func fetchMyClubs() async throws -> [MyClubResponse]
    
    func fetchMyApplyClubs() async throws -> [MyApplyClubResponse]
    
    func fetchClubRegisterTime() async throws -> ClubRegisterTimeResponse
}
