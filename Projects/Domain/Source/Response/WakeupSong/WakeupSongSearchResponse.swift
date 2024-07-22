//
//  WakeupSongSearchResponse.swift
//  DodamDodam
//
//  Created by Mercen on 4/1/24.
//
import SwiftBok

@Init()
@Members()
public struct WakeupSongSearchResponse: ResponseProtocol {
    
    public let videoTitle: String
    public let videoId: String
    public let videoUrl: String
    public let channelTitle: String
    public let thumbnail: String
}
