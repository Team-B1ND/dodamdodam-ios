//
//  PointResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

public struct PointResponse: ResponseProtocol {
    
    public let id: Int
    public let student: Student
    public let teacher: Teacher
    public let reason: PointReason
    public let issueAt: String
    
    public init(id: Int, student: Student, teacher: Teacher, reason: PointReason, issueAt: String) {
        self.id = id
        self.student = student
        self.teacher = teacher
        self.reason = reason
        self.issueAt = issueAt
    }
}
