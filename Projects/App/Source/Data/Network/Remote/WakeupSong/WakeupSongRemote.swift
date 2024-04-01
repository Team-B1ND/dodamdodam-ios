//
//  WakeupSongRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct WakeupSongRemote: RemoteProtocol {
    
    typealias Target = WakeupSongService
    
    func fetchWakeupSong() async throws -> Response<[WakeupSongResponse]> {
        try await self.request(target: .fetchWakeupSong)
            .map(Response<[WakeupSongResponse]>.self, using: decoder)
    }
    
    func fetchAllowedWakeupSong(
        _ request: FetchAllowedWakeupSongRequest
    ) async throws -> Response<[WakeupSongResponse]> {
        try await self.request(target: .fetchAllowedWakeupSong(request))
            .map(Response<[WakeupSongResponse]>.self, using: decoder)
    }
    
    func fetchPendingWakeupSong() async throws -> Response<[WakeupSongResponse]> {
        try await self.request(target: .fetchPendingWakeupSong)
            .map(Response<[WakeupSongResponse]>.self, using: decoder)
    }
    
    func fetchWakeupSongChart() async throws -> Response<[WakeupSongChartResponse]> {
        try await self.request(target: .fetchWakeupSongChart)
            .map(Response<[WakeupSongChartResponse]>.self, using: decoder)
    }
    
    func fetchWakeupSongByKeyword(
        _ request: FetchWakeupSongByKeywordRequest
    ) async throws -> Response<[WakeupSongSearchResponse]> {
        try await self.request(target: .fetchWakeupSongByKeyword(request))
            .map(Response<[WakeupSongSearchResponse]>.self, using: decoder)
    }
    
    func postWakeupSong(_ request: PostWakeupSongRequest) async throws -> DefaultResponse {
        try await self.request(target: .postWakeupSong(request))
            .map(DefaultResponse.self, using: decoder)
    }
    
    func postWakeupSongByKeyword(_ request: PostWakeupSongByKeywordRequest) async throws -> DefaultResponse {
        try await self.request(target: .postWakeupSongByKeyword(request))
            .map(DefaultResponse.self, using: decoder)
    }
    
    func deleteWakeupSong(id: Int) async throws -> DefaultResponse {
        try await self.request(target: .deleteWakeupSong(id: id))
            .map(DefaultResponse.self, using: decoder)
    }
}
