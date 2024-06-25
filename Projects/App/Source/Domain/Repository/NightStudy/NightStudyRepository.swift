//
//  NightStudyRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

protocol NightStudyRepository: RepositoryProtocol {
    
    func postNightStudy(_ request: PostNightStudyRequest) async throws -> DefaultResponse
    
    func deleteNightStudy(id: Int) async throws
    
    func fetchNightStudy() async throws -> [NightStudyResponse]
}
