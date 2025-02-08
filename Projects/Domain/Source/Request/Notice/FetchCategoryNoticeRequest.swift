//
//  FetchNoticeCategoryRequest.swift
//  Domain
//
//  Created by dgsw8th61 on 2/6/25.
//

public struct FetchCategoryNoticeRequest: RequestProtocol {
    
    public let lastId: Int
    public let limit: Int
    
    public init(lastId: Int, limit: Int) {
        self.lastId = lastId
        self.limit = limit
    }
}
