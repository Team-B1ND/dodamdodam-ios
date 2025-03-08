//
//  FetchNoticeRequest.swift
//  Domain
//
//  Created by dgsw8th61 on 2/6/25.
//

public struct FetchNoticeRequest: RequestProtocol {
    
    public let key: String?
    public let lastId: Int
    public let limit: Int
    public let status: NoticeStatus
    
    public init(key: String?, lastId: Int, limit: Int, status: NoticeStatus) {
        self.key = key
        self.lastId = lastId
        self.limit = limit
        self.status = status
    }
}
