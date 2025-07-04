//
//  OngoingNightStudyResponse.swift
//  Domain
//
//  Created by 김은찬 on 7/4/25.
//

import Foundation

public struct OngoingNightStudyResponse: ResponseProtocol {
    public let id: Int
    public let content: String
    public let status: AllowStatus
    public let doNeedPhone: Bool
    public let reasonForPhone: String
    public let student: Student
    public let rejectReason: String?
    public let startAt: String
    public let endAt: String
    public let createdAt: String
    public let modifiedAt: String
    
    public init(
        id: Int,
        content: String,
        status: AllowStatus,
        doNeedPhone: Bool,
        reasonForPhone: String,
        student: Student,
        rejectReason: String?,
        startAt: String,
        endAt: String,
        createdAt: String,
        modifiedAt: String
    ) {
        self.id = id
        self.content = content
        self.status = status
        self.doNeedPhone = doNeedPhone
        self.reasonForPhone = reasonForPhone
        self.student = student
        self.rejectReason = rejectReason
        self.startAt = startAt
        self.endAt = endAt
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
    }
}
