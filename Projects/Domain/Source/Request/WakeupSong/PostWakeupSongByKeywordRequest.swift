//
//  PostWakeupSongByKeywordRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import SwiftBok

@Init()
@Members()
public struct PostWakeupSongByKeywordRequest: RequestProtocol {
    
    public let artist: String
    public let title: String
}
