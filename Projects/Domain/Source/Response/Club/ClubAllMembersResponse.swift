//
//  ClubAllMembersResponse.swift
//  Domain
//
//  Created by dgsw30 on 2/26/25.
//

import Foundation

public struct ClubMembersInfoResponse: ResponseProtocol {
    public let isLeader: Bool
    public let students: [ClubMembersResponse]
    
    public init(isLeader: Bool, students: [ClubMembersResponse]) {
        self.isLeader = isLeader
        self.students = students
    }
}
