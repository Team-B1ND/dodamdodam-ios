//
//  NightStudyProjectResponse.swift
//  Domain
//
//  Created by dgsw01 on 5/6/25.
//

import Foundation

public struct NightStudyProjectResponse: ResponseProtocol {
    public let id: Int
    public let type: NightStudyProjectType
    public let status: AllowStatus
    public let room: NightProjectPlace
    public let name: String
    public let description: String
    public let startAt: Date
    public let endAt: Date
    public let leader: Student
    public let participants: [Student]
    
    public init(
        id: Int,
        type: NightStudyProjectType,
        status: AllowStatus,
        room: NightProjectPlace,
        name: String,
        description: String,
        startAt: Date,
        endAt: Date,
        leader: Student,
        participants: [Student]
    ) {
        self.id = id
        self.type = type
        self.status = status
        self.room = room
        self.name = name
        self.description = description
        self.startAt = startAt
        self.endAt = endAt
        self.leader = leader
        self.participants = participants
    }
}
