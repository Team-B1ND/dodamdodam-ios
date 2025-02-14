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
    public let keyword: String
    
    public init(lastId: Int, limit: Int, keyword: String) {
        self.lastId = lastId
        self.limit = limit
        self.keyword = keyword
    }
}
