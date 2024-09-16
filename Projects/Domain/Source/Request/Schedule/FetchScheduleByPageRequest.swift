//
//  FetchScheduleByPageRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct FetchScheduleByPageRequest: RequestProtocol {
    
    public let limit: Int
    public let page: Int
    
    public init(limit: Int, page: Int) {
        self.limit = limit
        self.page = page
    }
}
