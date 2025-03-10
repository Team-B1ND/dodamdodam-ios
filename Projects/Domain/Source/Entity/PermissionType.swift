//
//  ClubPermission.swift
//  Domain
//
//  Created by dgsw30 on 2/25/25.
//

import Foundation

public enum PermissionType: String, Codable, Hashable {
    case clubLeader = "CLUB_LEADER"
    case clubMember = "CLUB_MEMBER"
}
