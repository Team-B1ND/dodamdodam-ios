//
//  WakeupSongRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct WakeupSongRemote: RemoteProtocol {
    
    typealias Target = WakeupSongService
    
    func fetchWakeupSong() async throws -> Response<[WakeupSongResponse]> {
        try await self.request(target: .fetchWakeupSong, res: [WakeupSongResponse].self)
    }
    
    func fetchAllowedWakeupSong(
        _ request: FetchAllowedWakeupSongRequest
    ) async throws -> Response<[WakeupSongResponse]> {
        try await self.request(target: .fetchAllowedWakeupSong(request), res: [WakeupSongResponse].self)
    }
    
    func fetchPendingWakeupSong() async throws -> Response<[WakeupSongResponse]> {
        try await self.request(target: .fetchPendingWakeupSong, res: [WakeupSongResponse].self)
    }
    
    func fetchWakeupSongChart() async throws -> Response<[WakeupSongChartResponse]> {
        try await self.request(target: .fetchWakeupSongChart, res: [WakeupSongChartResponse].self)
    }
    
    func fetchWakeupSongByKeyword(
        _ request: FetchWakeupSongByKeywordRequest
    ) async throws -> Response<[WakeupSongSearchResponse]> {
        try await self.request(target: .fetchWakeupSongByKeyword(request), res: [WakeupSongSearchResponse].self)
    }
    
    func postWakeupSong(_ request: PostWakeupSongRequest) async throws -> DefaultResponse {
        try await self.request(target: .postWakeupSong(request))
    }
    
    func postWakeupSongByKeyword(_ request: PostWakeupSongByKeywordRequest) async throws -> DefaultResponse {
        try await self.request(target: .postWakeupSongByKeyword(request))
    }
    
    func deleteWakeupSong(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .deleteWakeupSong(id: id))
    }
}
