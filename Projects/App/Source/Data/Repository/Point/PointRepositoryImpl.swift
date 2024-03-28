//
//  PointRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct PointRepositoryImpl: PointRepository {
    
    let dataSource: PointDataSource
    
    func fetchPoint(_ request: FetchPointRequest) async throws -> [PointResponse] {
        try await dataSource.fetchPoint(request)
    }
    
    func fetchPointScore(_ request: FetchPointScoreRequest) async throws -> [PointScoreResponse] {
        try await dataSource.fetchPointScore(request)
    }
}
