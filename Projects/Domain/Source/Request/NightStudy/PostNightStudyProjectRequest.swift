//
//  PostNightStudyProjectRequest.swift
//  Domain
//
//  Created by dgsw01 on 5/6/25.
//

public struct PostNightStudyProjectRequest: RequestProtocol {
    public let type: NightStudyProjectType
    public let name: String
    public let description: String
    public let startAt: String
    public let endAt: String
    public let room: NightProjectPlace
    public let students: [Int]
    
    public init(
        type: NightStudyProjectType,
        name: String,
        description: String,
        startAt: String,
        endAt: String,
        room: NightProjectPlace,
        students: [Int]
    ) {
        self.type = type
        self.name = name
        self.description = description
        self.startAt = startAt
        self.endAt = endAt
        self.room = room
        self.students = students
    }
}
