//
//  WakeupSongResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation

struct WakeupSongResponse: ResponseProtocol {
    
    let id: Int
    let thumbnail: String
    let videoTitle: String
    let videoId: String
    let videoUrl: String
    let channelTitle: String
    let status: AllowStatus
    let createdAt: Date
}
