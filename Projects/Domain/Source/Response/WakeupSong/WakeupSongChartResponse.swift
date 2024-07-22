//
//  WakeupSongChartResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//
import SwiftBok

@Init()
@Members()
public struct WakeupSongChartResponse: ResponseProtocol {
    
    public let album: String
    public let artist: String
    public let name: String
    public let rank: Int
    public let thumbnail: String
}
