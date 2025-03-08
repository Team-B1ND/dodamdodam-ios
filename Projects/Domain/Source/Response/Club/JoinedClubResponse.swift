//
//  JoinedClubResponse.swift
//  Domain
//
//  Created by dgsw01 on 3/4/25.
//

import Foundation

public struct JoinedClubResponse: ResponseProtocol {
    public let id: Int
    public let name: String
    public let type: ClubType
    public let myStatus: StateType
    
    public init(id: Int, name: String, type: ClubType, myStatus: StateType) {
        self.id = id
        self.name = name
        self.type = type
        self.myStatus = myStatus
    }
}
