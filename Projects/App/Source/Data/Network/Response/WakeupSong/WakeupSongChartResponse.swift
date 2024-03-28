//
//  WakeupSongChartResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation

struct WakeupSongChartResponse: ResponseProtocol {
    
    let album: String
    let artist: String
    let name: String
    let rank: Int
    let thumbnail: String
}
