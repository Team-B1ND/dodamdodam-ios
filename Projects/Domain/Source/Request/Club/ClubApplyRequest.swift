//
//  ClubRequest.swift
//  Domain
//
//  Created by dgsw01 on 3/4/25.
//

import Foundation

public enum ClubPriority: String, Codable {
    case first = "CREATIVE_ACTIVITY_CLUB_1"
    case second = "CREATIVE_ACTIVITY_CLUB_2"
    case third = "CREATIVE_ACTIVITY_CLUB_3"
}

public struct ClubApplyRequest: Codable {
    public let clubId: Int
    public let clubPriority: String?
    public let introduction: String
    
    public init(clubId: Int, clubPriority: ClubPriority?, introduction: String) {
        self.clubId = clubId
        self.clubPriority = clubPriority?.rawValue 
        self.introduction = introduction
    }
}
