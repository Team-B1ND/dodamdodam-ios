//
//  NightStudyRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct NightStudyRepositoryImpl: NightStudyRepository {
    
    let dataSource: NightStudyDataSource
    
    func postNightStudy(_ request: PostNightStudyRequest) async throws -> DefaultResponse{
        try await dataSource.postNightStudy(request)
    }
    
    func deleteNightStudy(id: Int) async throws {
        try await dataSource.deleteNightStudy(id: id)
    }
    
    func fetchNightStudy() async throws -> [NightStudyResponse] {
        try await dataSource.fetchNightStudy()
    }
}
