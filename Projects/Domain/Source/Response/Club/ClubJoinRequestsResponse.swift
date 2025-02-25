//
//  ClubJoinRequestsResponse.swift
//  Domain
//
//  Created by dgsw30 on 2/26/25.
//

import Foundation

public struct ClubJoinRequestsResponse: ResponseProtocol {
    public let id: Int
    public let clubPermission: PermissionType
    public let status: StateType
    public let club: Club
    
    public init(id: Int, clubPermission: PermissionType, status: StateType, club: Club) {
        self.id = id
        self.clubPermission = clubPermission
        self.status = status
        self.club = club
    }
}
