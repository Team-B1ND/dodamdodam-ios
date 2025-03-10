//
//  치ㅕ.swift
//  Domain
//
//  Created by dgsw01 on 3/4/25.
//

import Foundation

public struct ClubApplyResponse: ResponseProtocol {
    public let id: Int
    public let clubId: Int
    public let studentId: Int
    public let introduction: String
    public let priority: ClubPriority?
    public let status: StateType
    
    public init(id: Int, clubId: Int, studentId: Int, introduction: String, priority: ClubPriority?, status: StateType) {
        self.id = id
        self.clubId = clubId
        self.studentId = studentId
        self.introduction = introduction
        self.priority = priority
        self.status = status
    }
}
