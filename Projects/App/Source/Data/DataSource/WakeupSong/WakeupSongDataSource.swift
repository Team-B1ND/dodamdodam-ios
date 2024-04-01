//
//  WakeupSongDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct WakeupSongDataSource: DataSourceProtocol {
    
    let remote: WakeupSongRemote
    
    func fetchWakeupSong() async throws -> [WakeupSongResponse] {
        let response = try await remote.fetchWakeupSong()
        return response.data
    }
    
    func fetchAllowedWakeupSong(_ request: FetchAllowedWakeupSongRequest) async throws -> [WakeupSongResponse] {
        let response = try await remote.fetchAllowedWakeupSong(request)
        return response.data
    }
    
    func fetchPendingWakeupSong() async throws -> [WakeupSongResponse] {
        let response = try await remote.fetchPendingWakeupSong()
        return response.data
    }
    
    func fetchWakeupSongChart() async throws -> [WakeupSongChartResponse] {
        let response = try await remote.fetchWakeupSongChart()
        return response.data
    }
    
    func fetchWakeupSongByKeyword(
        _ request: FetchWakeupSongByKeywordRequest
    ) async throws -> [WakeupSongSearchResponse] {
        let response = try await remote.fetchWakeupSongByKeyword(request)
        return response.data
    }
    
    func postWakeupSong(_ request: PostWakeupSongRequest) async throws {
        _ = try await remote.postWakeupSong(request)
    }
    
    func postWakeupSongByKeyword(_ request: PostWakeupSongByKeywordRequest) async throws {
        _ = try await remote.postWakeupSongByKeyword(request)
    }
    
    func deleteWakeupSong(id: Int) async throws {
        _ = try await remote.deleteWakeupSong(id: id)
    }
}
