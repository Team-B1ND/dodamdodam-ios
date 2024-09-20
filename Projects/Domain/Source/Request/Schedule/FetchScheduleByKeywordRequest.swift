//
//  FetchScheduleByKeywordRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct FetchScheduleByKeywordRequest: RequestProtocol {
    
    public let keyword: String
    
    public init(keyword: String) {
        self.keyword = keyword
    }
}
