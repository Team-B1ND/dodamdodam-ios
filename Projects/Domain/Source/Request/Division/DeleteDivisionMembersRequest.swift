//
//  DeleteDivisionMembersRequest.swift
//  Domain
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation

public struct DeleteDivisionMembersRequest: RequestProtocol {
    public let idList: [Int]
    public init(idList: [Int]) {
        self.idList = idList
    }
}
