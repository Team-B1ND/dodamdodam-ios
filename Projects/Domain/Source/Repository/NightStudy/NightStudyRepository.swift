//
//  NightStudyRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

public protocol NightStudyRepository: RepositoryProtocol {
    
    func postNightStudy(_ request: PostNightStudyRequest) async throws -> DefaultResponse
    
    func deleteNightStudy(id: Int) async throws
    
    func fetchNightStudy() async throws -> [NightStudyResponse]
    
    func checkBanStatus() async throws -> NightStudyBanResponse
    
    func searchStudents() async throws -> [NightStudyStudentResponse]
    
    func postNightStudyProject(_ request: PostNightStudyProjectRequest) async throws -> DefaultResponse
    
    func fetchNightStudyProjects() async throws -> [NightStudyProjectResponse]
    
    func deleteNightStudyProject(id: Int) async throws
    
    func fetchPendingNightStudy() async throws -> [OngoingNightStudyResponse]
    
    func banNightStudy(_ request: NightStudyBanRequest) async throws -> DefaultResponse
    
    func fetchApproveNightStudy() async throws -> [OngoingNightStudyResponse]
    
    func allowNightStudy(id: Int) async throws -> DefaultResponse
    
    func rejectNightStudy(id: Int) async throws -> DefaultResponse
}
