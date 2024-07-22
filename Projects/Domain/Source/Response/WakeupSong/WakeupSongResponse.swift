//
//  WakeupSongResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation
import SwiftBok

@Init()
@Members()
public struct WakeupSongResponse: ResponseProtocol {
    
    public let id: Int
    public let thumbnail: String
    public let videoTitle: String
    public let videoId: String
    public let videoUrl: String
    public let channelTitle: String
    public let status: AllowStatus
    public let createdAt: Date
}
