//
//  NoticeRemote.swift
//  Repository
//
//  Created by dgsw8th61 on 2/6/25.
//

import Domain

public struct NoticeRemote: RemoteProtocol {
    
    typealias Target = NoticeService
    
    public init() {}
    
    public func fetchNotice(_ request: FetchNoticeRequest) async throws -> Response<[NoticeResponse]> {
        try await self.request(target: .fetchNotice(request), res: [NoticeResponse].self)
    }
    
    public func fetchNoticeByDivision(_ request: FetchNoticeByDivisionRequest) async throws -> Response<[NoticeResponse]> {
        try await self.request(target: .fetchNoticeDivision(request), res: [NoticeResponse].self)
    }
}
