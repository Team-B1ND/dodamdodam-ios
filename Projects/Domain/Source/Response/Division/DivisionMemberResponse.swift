//
//  DivisionMemberResponse.swift
//  Domain
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation

public struct DivisionMemberResponse: ResponseProtocol {
    public let id: Int
    public let memberId: String
    public let memberName: String
    public let profileImage: String?
    public let permission: DivisionPermission
    public let grade: Int?
    public let room: Int?
    public let number: Int?
    public let role: Role
    
    public init(id: Int, memberId: String, memberName: String, profileImage: String?, permission: DivisionPermission, grade: Int?, room: Int?, number: Int?, role: Role) {
        self.id = id
        self.memberId = memberId
        self.memberName = memberName
        self.profileImage = profileImage
        self.permission = permission
        self.grade = grade
        self.room = room
        self.number = number
        self.role = role
    }
}

public extension [DivisionMemberResponse] {
    func find(permission: DivisionPermission) -> Self {
        filter { $0.permission == permission }
    }
}
