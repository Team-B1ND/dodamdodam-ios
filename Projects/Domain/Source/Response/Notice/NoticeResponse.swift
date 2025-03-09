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
    public let noticeStatus: NoticeStatus
    public let noticeFileRes: [NoticeFileResponse]
    public let memberInfoRes: MemberResponse
    public let createdAt: Date
    public let modifiedAt: Date
    
    public init(
        id: Int,
        title: String,
        content: String,
        noticeStatus: NoticeStatus,
        noticeFileRes: [NoticeFileResponse],
        memberInfoRes: MemberResponse,
        createdAt: Date,
        modifiedAt: Date
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.noticeFileRes = noticeFileRes
        self.noticeStatus = noticeStatus
        self.memberInfoRes = memberInfoRes
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
    }
}
