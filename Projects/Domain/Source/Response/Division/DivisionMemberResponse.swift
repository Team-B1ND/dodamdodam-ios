//
//  DivisionMemberResponse.swift
//  Domain
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation

public struct DivisionMemberResponse: ResponseProtocol {
    public let id: Int
    public let memberName: String
    public let profileImage: String?
    public let permission: DivisionPermission
    public let grade: Int?
    public let room: Int?
    public let number: Int?
    
    public init(id: Int, memberName: String, profileImage: String?, permission: DivisionPermission, grade: Int?, room: Int?, number: Int?) {
        self.id = id
        self.memberName = memberName
        self.profileImage = profileImage
        self.permission = permission
        self.grade = grade
        self.room = room
        self.number = number
    }
}
