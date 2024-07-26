//
//  FetchWakeupSongByKeywordRequest.swift
//  DodamDodam
//
//  Created by Mercen on 4/1/24.
//

import SwiftBok

@Init()
@Members()
public struct FetchWakeupSongByKeywordRequest: RequestProtocol {
    
    public let keyword: String
}
