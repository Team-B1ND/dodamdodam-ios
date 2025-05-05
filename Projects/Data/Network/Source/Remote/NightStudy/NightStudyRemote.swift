//
//  NightStudyRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain

public struct NightStudyRemote: RemoteProtocol {
    
    typealias Target = NightStudyService
    
    public init() {}
    
    public func postNightStudy(_ request: PostNightStudyRequest) async throws -> Response<DefaultResponse> {
        try await self.request(target: .postNightStudy(request), res: DefaultResponse.self)
    }
    
    public func deleteNightStudy(id: Int) async throws -> Response<DefaultResponse> {
        try await self.request(target: .deleteNightStudy(id: id), res: DefaultResponse.self)
    }
    
    public func fetchNightStudy() async throws -> Response<[NightStudyResponse]> {
        try await self.request(target: .fetchNightStudy, res: [NightStudyResponse].self)
    }
    
    public func checkBanStatus() async throws -> Response<NightStudyBanResponse> {
        try await self.request(target: .checkBanStatus, res: NightStudyBanResponse.self)
    }
    
    public func searchStudents(query: String) async throws -> Response<[NightStudyStudentResponse]> {
        try await self.request(target: .searchStudents(query: query), res: [NightStudyStudentResponse].self)
    }
    
    public func postNightStudyProject(_ request: PostNightStudyProjectRequest) async throws -> Response<DefaultResponse> {
        try await self.request(target: .postNightStudyProject(request), res: DefaultResponse.self)
    }
    
    public func fetchNightStudyProject() async throws -> Response<[NightStudyProjectResponse]> {
        try await self.request(target: .fetchNightStudyProject, res: [NightStudyProjectResponse].self)
    }
    
    public func deleteNightStudyProject(id: Int) async throws -> Response<DefaultResponse> {
        try await self.request(target: .deleteNightStudyProject(id: id), res: DefaultResponse.self)
    }
}
