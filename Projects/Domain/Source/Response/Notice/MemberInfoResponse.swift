//
//  MemberInfoResponse.swift
//  Domain
//
//  Created by dgsw8th61 on 2/6/25.
//

import Foundation

public struct MemberInfoResponse: ResponseProtocol {
    
    public let id: String
    public let name: String
    public let email: String
    public let role: String 
    public let status: String
    public let profileImage: String?
    public let phone: String
    public let student: String?
    public let teacher: String?
    public let createdAt: String
    public let modifiedAt: String

    public init(
        id: String,
        name: String,
        email: String,
        role: String,
        status: String,
        profileImage: String?,
        phone: String,
        student: String?,
        teacher: String?,
        createdAt: String,
        modifiedAt: String
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
