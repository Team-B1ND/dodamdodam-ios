//
//  Member.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation

public struct Member: Codable, Hashable {
    
    public let createdAt: Date
    public let modifiedAt: Date?
    public let id: String
    public let name: String
    public let role: Role
    public let status: ActiveStatus
    public let profileImage: URL?
    public let phone: String
    
    public init(createdAt: Date, modifiedAt: Date?, id: String, name: String, role: Role, status: ActiveStatus, profileImage: URL?, phone: String) {
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
        self.id = id
        self.name = name
        self.role = role
        self.status = status
        self.profileImage = profileImage
        self.phone = phone
    }
}
