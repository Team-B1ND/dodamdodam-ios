//
//  FetchDivisionMembersRequest.swift
//  Domain
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation

public struct FetchDivisionMembersRequest: RequestProtocol {
    public let status: AllowStatus
    
    public init(status: AllowStatus) {
        self.status = status
    }
}
