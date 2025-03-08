//
//  FetchNoticeCategoryRequest.swift
//  Domain
//
//  Created by dgsw8th61 on 2/6/25.
//

public struct FetchNoticeByDivisionRequest: RequestProtocol {
    
    public let lastId: Int
    public let id: Int?
    public let limit: Int
    
    public init(lastId: Int, id: Int?, limit: Int) {
        self.lastId = lastId
        self.id = id
        self.limit = limit
    }
}
