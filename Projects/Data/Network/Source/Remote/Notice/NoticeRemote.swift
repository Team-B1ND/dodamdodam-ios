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
    
    public func fetchCategoryNotice(id: Int, _ request: FetchCategoryNoticeRequest) async throws -> Response<[NoticeResponse]> {
        try await self.request(target: .fetchCategoryNotice(id: id, request), res: [NoticeResponse].self)
    }
}
