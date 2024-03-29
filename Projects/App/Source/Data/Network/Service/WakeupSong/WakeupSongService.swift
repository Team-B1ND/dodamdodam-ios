//
//  WakeupSongService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation
import Moya

enum WakeupSongService: ServiceProtocol {
    
    case fetchWakeupSong
    case fetchAllowedWakeupSong(_ request: FetchAllowedWakeupSongRequest)
    case fetchPendingWakeupSong
    case fetchWakeupSongChart
    case postWakeupSong(_ request: PostWakeupSongRequest)
    case postWakeupSongByKeyword(_ request: PostWakeupSongByKeywordRequest)
    case deleteWakeupSong(id: Int)
}

extension WakeupSongService {
    
    var baseURL: URL {
        host.appendingPathComponent("wakeup-song")
    }
    
    var path: String {
        switch self {
        case .fetchWakeupSong: "/my"
        case .fetchAllowedWakeupSong: "/allowed"
        case .fetchPendingWakeupSong: "/pending"
        case .fetchWakeupSongChart: "/chart"
        case .postWakeupSong: ""
        case .postWakeupSongByKeyword: "/keyword"
        case let .deleteWakeupSong(id): "/my/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchWakeupSong: .get
        case .fetchAllowedWakeupSong: .get
        case .fetchPendingWakeupSong: .get
        case .fetchWakeupSongChart: .get
        case .postWakeupSong: .post
        case .postWakeupSongByKeyword: .post
        case .deleteWakeupSong: .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchWakeupSong:
                .requestPlain
        case let .fetchAllowedWakeupSong(request):
            request.toURLParameters()
        case .fetchPendingWakeupSong:
                .requestPlain
        case .fetchWakeupSongChart:
                .requestPlain
        case let .postWakeupSong(request):
            request.toJSONParameters()
        case let .postWakeupSongByKeyword(request):
            request.toJSONParameters()
        case .deleteWakeupSong:
                .requestPlain
        }
    }
}
