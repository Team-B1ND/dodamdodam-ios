//
//  WakeupSongDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import Network

public struct WakeupSongDataSource: DataSourceProtocol {
    let remote: WakeupSongRemote
    
    public init(remote: WakeupSongRemote) {
        self.remote = remote
    }
    
    public func fetchWakeupSong() async throws -> [WakeupSongResponse] {
        let response = try await remote.fetchWakeupSong()
        return response.data
    }
    
    public func fetchAllowedWakeupSong(_ request: FetchAllowedWakeupSongRequest) async throws -> [WakeupSongResponse] {
        let response = try await remote.fetchAllowedWakeupSong(request)
        return response.data
    }
    
    public func fetchPendingWakeupSong() async throws -> [WakeupSongResponse] {
        let response = try await remote.fetchPendingWakeupSong()
        return response.data
    }
    
    public func fetchWakeupSongChart() async throws -> [WakeupSongChartResponse] {
        let response = try await remote.fetchWakeupSongChart()
        return response.data
    }
    
    public func fetchWakeupSongByKeyword(
        _ request: FetchWakeupSongByKeywordRequest
    ) async throws -> [WakeupSongSearchResponse] {
        let response = try await remote.fetchWakeupSongByKeyword(request)
        return response.data
    }
    
    public func postWakeupSong(_ request: PostWakeupSongRequest) async throws {
        _ = try await remote.postWakeupSong(request)
    }
    
    public func postWakeupSongByKeyword(_ request: PostWakeupSongByKeywordRequest) async throws {
        _ = try await remote.postWakeupSongByKeyword(request)
    }
    
    public func deleteWakeupSong(id: Int) async throws {
        _ = try await remote.deleteWakeupSong(id: id)
    }
}
