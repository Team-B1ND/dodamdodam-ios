//
//  FetchWakeupSongByKeywordRequest.swift
//  DodamDodam
//
//  Created by Mercen on 4/1/24.
//

public struct FetchWakeupSongByKeywordRequest: RequestProtocol {
    
    public let keyword: String
    
    public init(keyword: String) {
        self.keyword = keyword
    }
}
