//
//  WakeupSongRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain

public struct WakeupSongRemote: RemoteProtocol {
    
    typealias Target = WakeupSongService
    
    public init() {}
    
    public func fetchWakeupSong() async throws -> Response<[WakeupSongResponse]> {
        try await self.request(target: .fetchWakeupSong, res: [WakeupSongResponse].self)
    }
    
    public func fetchAllowedWakeupSong(
        _ request: FetchAllowedWakeupSongRequest
    ) async throws -> Response<[WakeupSongResponse]> {
        try await self.request(target: .fetchAllowedWakeupSong(request), res: [WakeupSongResponse].self)
    }
    
    public func fetchPendingWakeupSong() async throws -> Response<[WakeupSongResponse]> {
        try await self.request(target: .fetchPendingWakeupSong, res: [WakeupSongResponse].self)
    }
    
    public func fetchWakeupSongChart() async throws -> Response<[WakeupSongChartResponse]> {
        try await self.request(target: .fetchWakeupSongChart, res: [WakeupSongChartResponse].self)
    }
    
    public func fetchWakeupSongByKeyword(
        _ request: FetchWakeupSongByKeywordRequest
    ) async throws -> Response<[WakeupSongSearchResponse]> {
        try await self.request(target: .fetchWakeupSongByKeyword(request), res: [WakeupSongSearchResponse].self)
    }
    
    public func postWakeupSong(_ request: PostWakeupSongRequest) async throws -> DefaultResponse {
        try await self.request(target: .postWakeupSong(request))
    }
    
    public func postWakeupSongByKeyword(_ request: PostWakeupSongByKeywordRequest) async throws -> DefaultResponse {
        try await self.request(target: .postWakeupSongByKeyword(request))
    }
    
    public func deleteWakeupSong(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .deleteWakeupSong(id: id))
    }
}
