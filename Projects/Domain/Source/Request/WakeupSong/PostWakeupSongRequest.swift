//
//  PostWakeupSongRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct PostWakeupSongRequest: RequestProtocol {
    
    public let videoUrl: String
    
    public init(videoUrl: String) {
        self.videoUrl = videoUrl
    }
}
