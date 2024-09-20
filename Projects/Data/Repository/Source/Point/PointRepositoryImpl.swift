//
//  PointRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import DataSource

public struct PointRepositoryImpl: PointRepository {
    
    let dataSource: PointDataSource
    
    public init(dataSource: PointDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchPoint(_ request: FetchPointRequest) async throws -> [PointResponse] {
        try await dataSource.fetchPoint(request)
    }
    
    public func fetchPointScore(_ request: FetchPointScoreRequest) async throws -> PointScoreResponse {
        try await dataSource.fetchPointScore(request)
    }
}
