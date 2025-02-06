//
//  FetchDivisionRequest.swift
//  Domain
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation

public struct FetchDivisionRequest: RequestProtocol {
    public let lastId: Int
    public let limit: Int
    
    public init(lastId: Int, limit: Int) {
        self.lastId = lastId
        self.limit = limit
    }
}
