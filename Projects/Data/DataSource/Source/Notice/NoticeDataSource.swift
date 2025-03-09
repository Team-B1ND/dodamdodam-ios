//
//  NoticeDataSource.swift
//  Repository
//
//  Created by dgsw8th61 on 2/6/25.
//

import Domain
import Network

public struct NoticeDataSource: DataSourceProtocol {
    let remote: NoticeRemote
    
    public init(remote: NoticeRemote) {
        self.remote = remote
    }
    
    public func fetchNotice(_ request: FetchNoticeRequest) async throws -> [NoticeResponse] {
        let response = try await remote.fetchNotice(request)
        return response.data
    }
    
    public func fetchNoticeByDivision(_ request: FetchNoticeByDivisionRequest) async throws -> [NoticeResponse] {
        let response = try await remote.fetchNoticeByDivision(request)
        return response.data
    }
}
