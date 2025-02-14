//
//  NoticeResponse.swift
//  Domain
//
//  Created by dgsw8th61 on 2/6/25.
//

import Foundation

public struct NoticeResponse: ResponseProtocol {
    
    public let id: Int
    public let title: String
    public let content: String
    public let fileUrl: String?
    public let fileType: String?
    public let noticeStatus: NoticeStatus
    public let memberInfoRes: MemberInfoResponse
    public let createdAt: String
    public let modifiedAt: String
    
    public init(
        id: Int,
        title: String,
        content: String,
        fileUrl: String?,
        fileType: String?,
        noticeStatus: NoticeStatus,
        memberInfoRes: MemberInfoResponse,
        createdAt: String,
        modifiedAt: String
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.fileUrl = fileUrl
        self.fileType = fileType
        self.noticeStatus = noticeStatus
        self.memberInfoRes = memberInfoRes
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
    }
}
