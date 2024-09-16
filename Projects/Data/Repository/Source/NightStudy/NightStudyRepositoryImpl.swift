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
    
    public func postNightStudy(_ request: PostNightStudyRequest) async throws -> DefaultResponse{
        try await dataSource.postNightStudy(request)
    }
    
    public func deleteNightStudy(id: Int) async throws {
        try await dataSource.deleteNightStudy(id: id)
    }
    
    public func fetchNightStudy() async throws -> [NightStudyResponse] {
        try await dataSource.fetchNightStudy()
    }
}
