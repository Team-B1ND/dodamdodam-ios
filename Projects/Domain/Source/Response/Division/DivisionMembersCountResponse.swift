//
//  DivisionMembersCountResponse.swift
//  Domain
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation

public struct DivisionMembersCountResponse: ResponseProtocol {
    public let count: Int
    
    public init(count: Int) {
        self.count = count
    }
}
