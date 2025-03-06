//
//  ClubAllMembersResponse.swift
//  Domain
//
//  Created by dgsw30 on 2/26/25.
//

import Foundation

public struct ClubAllMembersResponse: ResponseProtocol {
    public let id: Int
    public let status: StateType
    public let permission: PermissionType
    public let studentId: Int
    public let name: String
    public let grade: Int
    public let room: Int
    public let number: Int
    public let profileImage: String?
    
    public init(id: Int, status: StateType, permission: PermissionType, studentId: Int, name: String, grade: Int, room: Int, number: Int, profileImage: String?) {
        self.id = id
        self.status = status
        self.permission = permission
        self.studentId = studentId
        self.name = name
        self.grade = grade
        self.room = room
        self.number = number
        self.profileImage = profileImage
    }
}
