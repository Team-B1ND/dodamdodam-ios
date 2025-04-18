//
//  NightStudyResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation

public struct NightStudyResponse: ResponseProtocol {
    //MARK: response 수정 해야할수도?
    public let id: Int
    public let content: String
    public let status: AllowStatus
    public let doNeedPhone: Bool
    public let reasonForPhone: String?
    public let student: Student
    public let rejectReason: String?
    public let place: NightStudyPlace
    public let startAt: Date
    public let endAt: Date
    public let createdAt: Date
    public let modifiedAt: Date?
    
    public init(
        id: Int,
        content: String,
        status: AllowStatus,
        doNeedPhone: Bool,
        reasonForPhone: String?,
        student: Student,
        rejectReason: String?,
        place: NightStudyPlace,
        startAt: Date,
        endAt: Date,
        createdAt: Date,
        modifiedAt: Date?
    ) {
        self.id = id
        self.content = content
        self.status = status
        self.doNeedPhone = doNeedPhone
        self.reasonForPhone = reasonForPhone
        self.student = student
        self.rejectReason = rejectReason
        self.place = place
        self.startAt = startAt
        self.endAt = endAt
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
    }
}
