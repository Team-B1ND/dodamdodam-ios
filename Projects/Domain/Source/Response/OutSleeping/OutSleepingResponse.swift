//
//  OutSleepingResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation

public struct OutSleepingResponse: ResponseProtocol {
    
    public let id: Int
    public let reason: String
    public let status: AllowStatus
    public let student: Student
    public let rejectReason: String?
    public let startAt: Date
    public let endAt: Date
    public let createdAt: Date
    public let modifiedAt: Date?
    
    public init(id: Int, reason: String, status: AllowStatus, student: Student, rejectReason: String?, startAt: Date, endAt: Date, createdAt: Date, modifiedAt: Date?) {
        self.id = id
        self.reason = reason
        self.status = status
        self.student = student
        self.rejectReason = rejectReason
        self.startAt = startAt
        self.endAt = endAt
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
    }
}
