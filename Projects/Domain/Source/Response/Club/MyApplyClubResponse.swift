//
//  MyApplyClubResponse.swift
//  Domain
//
//  Created by dgsw30 on 3/8/25.
//

import Foundation

public struct MyApplyClubResponse: ResponseProtocol {
    public let id: Int
    public let clubPermission: PermissionType
    public let priority: ClubPriority
    public let introduction: String
    public let club: ClubsResponse
    
    public init(id: Int, clubPermission: PermissionType, priority: ClubPriority, introduction: String, club: ClubsResponse) {
        self.id = id
        self.clubPermission = clubPermission
        self.priority = priority
        self.introduction = introduction
        self.club = club
    }
}
