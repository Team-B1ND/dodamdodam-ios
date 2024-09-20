//
//  WakeupSongChartResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

public struct WakeupSongChartResponse: ResponseProtocol {
    
    public let album: String
    public let artist: String
    public let name: String
    public let rank: Int
    public let thumbnail: String
    
    public init(album: String, artist: String, name: String, rank: Int, thumbnail: String) {
        self.album = album
        self.artist = artist
        self.name = name
        self.rank = rank
        self.thumbnail = thumbnail
    }
}
