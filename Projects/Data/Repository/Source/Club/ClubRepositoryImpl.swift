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
    
    public func fetchClubMembers(id: Int) async throws -> [ClubMembersResponse] {
        return try await dataSource.fetchClubMembers(id: id)
    }
    
    public func fetchAllClubMembers(id: Int) async throws -> [ClubAllMembersResponse] {
        return try await dataSource.fetchAllClubMembers(id: id)
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
}
