//
//  ClubRequest.swift
//  Domain
//
//  Created by dgsw01 on 3/4/25.
//

import Foundation

public struct ClubApplyRequest: Codable {
    public let clubId: Int
    public let clubPriority: String?
    public let introduction: String?
    
    public init(clubId: Int, clubPriority: ClubPriority?, introduction: String?) {
        self.clubId = clubId
        self.clubPriority = clubPriority?.rawValue
        self.introduction = introduction
    }
}
