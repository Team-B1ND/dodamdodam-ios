//
//  MemberResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//
import Foundation
public struct MemberResponse: ResponseProtocol {
    
    public let id: String
    public let name: String
    public let email: String
    public let role: Role
    public let status: ActiveStatus
    public let profileImage: String?
    public let phone: String
    public let student: Student?
    public let teacher: Teacher?
    public let createdAt: Date
    public let modifiedAt: Date?
    
    public init(
        id: String,
        name: String,
        email: String,
        role: Role,
        status: ActiveStatus,
        profileImage: String?,
        phone: String,
        student: Student?,
        teacher: Teacher?,
        createdAt: Date,
        modifiedAt: Date?
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.role = role
        self.status = status
        self.profileImage = profileImage
        self.phone = phone
        self.student = student
        self.teacher = teacher
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
    }
}
