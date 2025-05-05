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
    
    public init(remote: NightStudyRemote = .init()) {
        self.remote = remote
    }
}

extension NightStudyDataSource {
    
    public func postNightStudy(_ request: PostNightStudyRequest) async throws -> DefaultResponse {
        try await remote.postNightStudy(request).data
    }
    
    public func deleteNightStudy(id: Int) async throws -> DefaultResponse {
        try await remote.deleteNightStudy(id: id).data
    }
    
    public func fetchNightStudy() async throws -> [NightStudyResponse] {
        try await remote.fetchNightStudy().data
    }
    
    public func checkBanStatus() async throws -> NightStudyBanResponse {
        try await remote.checkBanStatus().data
    }
    
    public func searchStudents(query: String) async throws -> [NightStudyStudentResponse] {
        try await remote.searchStudents(query: query).data
    }
    
    public func postNightStudyProject(_ request: PostNightStudyProjectRequest) async throws -> DefaultResponse {
        try await remote.postNightStudyProject(request).data
    }
    
    public func fetchNightStudyProject() async throws -> [NightStudyProjectResponse] {
        try await remote.fetchNightStudyProject().data
    }
    
    public func deleteNightStudyProject(id: Int) async throws -> DefaultResponse {
        try await remote.deleteNightStudyProject(id: id).data
    }
}
