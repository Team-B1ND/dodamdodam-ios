//
//  NightStudyRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import DataSource

public struct NightStudyRepositoryImpl: NightStudyRepository {
    
    let dataSource: NightStudyDataSource
    
    public init(dataSource: NightStudyDataSource) {
        self.dataSource = dataSource
    }
    
    public func postNightStudy(_ request: PostNightStudyRequest) async throws -> DefaultResponse {
        try await dataSource.postNightStudy(request)
    }
    
    public func deleteNightStudy(id: Int) async throws {
        try await dataSource.deleteNightStudy(id: id)
    }
    
    public func fetchNightStudy() async throws -> [NightStudyResponse] {
        try await dataSource.fetchNightStudy()
    }
    
    public func checkBanStatus() async throws -> NightStudyBanResponse {
        try await dataSource.checkBanStatus()
    }
    
    public func searchStudents() async throws -> [NightStudyStudentResponse] {
        try await dataSource.searchStudents()
    }
    
    public func postNightStudyProject(_ request: PostNightStudyProjectRequest) async throws -> DefaultResponse {
        try await dataSource.postNightStudyProject(request)
    }
    
    public func fetchNightStudyProjects() async throws -> [NightStudyProjectResponse] {
        try await dataSource.fetchNightStudyProject()
    }
    
    public func deleteNightStudyProject(id: Int) async throws {
        try await dataSource.deleteNightStudyProject(id: id)
    }
    
    /*
    public func fetchUsingRoom() async throws -> [NightProjectUsingRoomResponse] {
        try await dataSource.fetchUsingRoom()
    }
    */
    
    public func fetchPendingNightStudy() async throws -> [OngoingNightStudyResponse] {
        try await dataSource.fetchPendingNightStudy()
    }
    
    public func banNightStudy(_ request: NightStudyBanRequest) async throws -> DefaultResponse {
        try await dataSource.banNightStudy(request: request)
    }
    
    public func fetchApproveNightStudy() async throws -> [OngoingNightStudyResponse] {
        try await dataSource.fetchApproveNightStudy()
    }
}
