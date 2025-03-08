//
//  NoticeRepositoryImpl.swift
//  Repository
//
//  Created by dgsw8th61 on 2/6/25.
//

import DataSource
import Domain

public struct NoticeRepositoryImpl: NoticeRepository {
    
    let dataSource: NoticeDataSource
    
    public init(dataSource: NoticeDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchNotice(_ request: FetchNoticeRequest) async throws -> [NoticeResponse] {
        try await dataSource.fetchNotice(request)
    }
    
    public func fetchNoticeByDivision(_ request: FetchNoticeByDivisionRequest) async throws -> [NoticeResponse] {
        try await dataSource.fetchNoticeByDivision(request)
    }
}
