//
//  PatchMemberStatus.swift
//  Domain
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation

public struct PatchMembersStatusRequest: RequestProtocol {
    public let idList: [Int]
    public let status: AllowStatus
    
    public init(idList: [Int], status: AllowStatus) {
        self.idList = idList
        self.status = status
    }
}
