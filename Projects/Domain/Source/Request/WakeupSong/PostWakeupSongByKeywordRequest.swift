//
//  PostWakeupSongByKeywordRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct PostWakeupSongByKeywordRequest: RequestProtocol {
    
    public let artist: String
    public let title: String
    
    public init(artist: String, title: String) {
        self.artist = artist
        self.title = title
    }
}
