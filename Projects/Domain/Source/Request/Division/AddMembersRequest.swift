//
//  AddMembersRequest.swift
//  Domain
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation

public struct AddMembersRequest: RequestProtocol {
    public let memberIdList: [String]
    public init(memberIdList: [String]) {
        self.memberIdList = memberIdList
    }
}
