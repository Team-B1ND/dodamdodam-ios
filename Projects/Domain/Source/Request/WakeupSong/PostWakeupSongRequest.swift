//
//  PostWakeupSongRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import SwiftBok

@Init()
@Members()
public struct PostWakeupSongRequest: RequestProtocol {
    
    public let videoUrl: String
}
