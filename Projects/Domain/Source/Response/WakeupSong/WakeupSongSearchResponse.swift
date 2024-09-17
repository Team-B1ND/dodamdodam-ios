//
//  WakeupSongSearchResponse.swift
//  DodamDodam
//
//  Created by Mercen on 4/1/24.
//

public struct WakeupSongSearchResponse: ResponseProtocol {
    
    public let videoTitle: String
    public let videoId: String
    public let videoUrl: String
    public let channelTitle: String
    public let thumbnail: String
    
    public init(videoTitle: String, videoId: String, videoUrl: String, channelTitle: String, thumbnail: String) {
        self.videoTitle = videoTitle
        self.videoId = videoId
        self.videoUrl = videoUrl
        self.channelTitle = channelTitle
        self.thumbnail = thumbnail
    }
}
