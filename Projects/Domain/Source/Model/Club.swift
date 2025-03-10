//
//  Club.swift
//  Domain
//
//  Created by dgsw30 on 2/26/25.
//

import Foundation

public struct Club: Codable, Hashable {
    public let id: Int
    public let name: String
    public let shortDescription: String
    public let description: String
    public let subject: String
    public let type: ClubType
    public let teacherId: Int?
    public let state: StateType
    
    public init(id: Int, name: String, shortDescription: String, description: String, subject: String, type: ClubType, teacherId: Int?, state: StateType) {
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.description = description
        self.subject = subject
        self.type = type
        self.teacherId = teacherId
        self.state = state
    }
}
