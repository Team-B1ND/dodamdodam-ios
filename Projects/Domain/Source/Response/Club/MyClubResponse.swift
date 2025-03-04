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
    public let teacher: Int?
    public let state: StateType
    
    private enum CodingKeys: String, CodingKey {
        case id, name, shortDescription, description, image, subject, type, teacher, state
    }
}
