//
//  ClubsResponse.swift
//  Domain
//
//  Created by dgsw30 on 2/25/25.
//

import Foundation

public struct ClubsResponse: ResponseProtocol {
    public let id: Int
    public let name: String
    public let shortDescription: String?
    public let description: String?
    public let subject: String?
    public let image: String
    public let type: ClubType
    public let teacher: Int?
    public let state: StateType

    public init(id: Int, name: String, shortDescription: String, description: String, subject: String, image: String, type: ClubType, teacher: Int, state: StateType) {
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.description = description
        self.subject = subject
        self.image = image
        self.type = type
        self.teacher = teacher
        self.state = state
    }
}
