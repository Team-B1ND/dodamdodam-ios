//
//  NightStudyDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import Network

public final class NightStudyDataSource {
    private let remote: NightStudyRemote
    
    public init(remote: NightStudyRemote) {
        self.remote = remote
    }
    
    public func postNightStudy(_ request: PostNightStudyRequest) async throws {
        _ = try await remote.postNightStudy(request)
    }
    
    public func deleteNightStudy(id: Int) async throws {
        _ = try await remote.deleteNightStudy(id: id)
    }
    
    public func fetchNightStudy() async throws -> [NightStudyResponse] {
        let response = try await remote.fetchNightStudy()
        return response.data
    }
    
    public func checkBanStatus() async throws -> NightStudyBanResponse {
        let response = try await remote.checkBanStatus()
        return response.data
    }
    
    public func searchStudents(query: String) async throws -> [NightStudyStudentResponse] {
        let response = try await remote.searchStudents(query: query)
        return response.data
    }
    
    public func postNightStudyProject(_ request: PostNightStudyProjectRequest) async throws {
        _ = try await remote.postNightStudyProject(request)
    }
    
    public func fetchNightStudyProject() async throws -> [NightStudyProjectResponse] {
        let response = try await remote.fetchNightStudyProject()
        return response.data
    }
    
    public func deleteNightStudyProject(id: Int) async throws {
        _ = try await remote.deleteNightStudyProject(id: id)
    }
}
