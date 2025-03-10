//
//  MyClubResponse.swift
//  Domain
//
//  Created by dgsw01 on 3/4/25.
//

import Foundation

public struct MyClubResponse: ResponseProtocol {
    public let id: Int
    public let name: String
    public let shortDescription: String
    public let description: String
    public let image: String?
    public let subject: String
    public let type: ClubType
    public let teacher: ClubTeacher?
    public let state: StateType
    
    public init(id: Int, name: String, shortDescription: String, description: String, image: String?, subject: String, type: ClubType, teacher: ClubTeacher?, state: StateType) {
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.description = description
        self.image = image
        self.subject = subject
        self.type = type
        self.teacher = teacher
        self.state = state
    }
}
