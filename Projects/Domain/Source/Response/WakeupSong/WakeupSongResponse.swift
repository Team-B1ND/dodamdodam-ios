//
//  WakeupSongResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation

public struct WakeupSongResponse: ResponseProtocol {
    
    public let id: Int
    public let thumbnail: String
    public let videoTitle: String
    public let videoId: String
    public let videoUrl: String
    public let channelTitle: String
    public let status: AllowStatus
    public let createdAt: Date
    
    public init(id: Int, thumbnail: String, videoTitle: String, videoId: String, videoUrl: String, channelTitle: String, status: AllowStatus, createdAt: Date) {
        self.id = id
        self.thumbnail = thumbnail
        self.videoTitle = videoTitle
        self.videoId = videoId
        self.videoUrl = videoUrl
        self.channelTitle = channelTitle
        self.status = status
        self.createdAt = createdAt
    }
}
