//
//  NightStudyStudentResponse.swift
//  Domain
//
//  Created by dgsw01 on 5/5/25.
//

import Foundation

public struct NightStudyStudentResponse: Codable, Hashable {
    public let id: Int
    public let name: String
    public let grade: Int
    public let room: Int
    public let number: Int
    public let phone: String?
    public let profileImage: String?
    public let isBanned: Bool
    
    public init(
        id: Int,
        name: String,
        grade: Int,
        room: Int,
        number: Int,
        phone: String,
        profileImage: String,
        isBanned: Bool
    ) {
        self.id = id
        self.name = name
        self.grade = grade
        self.room = room
        self.number = number
        self.phone = phone
        self.profileImage = profileImage
        self.isBanned = isBanned
    }
    
    public var classNumber: String {
        "\(grade)-\(room)"
    }
}
