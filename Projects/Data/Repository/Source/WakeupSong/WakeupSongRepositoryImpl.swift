//
//  WakeupSongRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import DataSource

public struct WakeupSongRepositoryImpl: WakeupSongRepository {
    
    let dataSource: WakeupSongDataSource
    
    public init(dataSource: WakeupSongDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchWakeupSong() async throws -> [WakeupSongResponse] {
        try await dataSource.fetchWakeupSong()
    }
    
    public func fetchAllowedWakeupSong(_ request: FetchAllowedWakeupSongRequest) async throws -> [WakeupSongResponse] {
        try await dataSource.fetchAllowedWakeupSong(request)
    }
    
    public func fetchPendingWakeupSong() async throws -> [WakeupSongResponse] {
        try await dataSource.fetchPendingWakeupSong()
    }
    
    public func fetchWakeupSongChart() async throws -> [WakeupSongChartResponse] {
        try await dataSource.fetchWakeupSongChart()
    }
    
    public func fetchWakeupSongByKeyword(
        _ request: FetchWakeupSongByKeywordRequest
    ) async throws -> [WakeupSongSearchResponse] {
        try await dataSource.fetchWakeupSongByKeyword(request)
    }
    
    public func postWakeupSong(_ request: PostWakeupSongRequest) async throws {
        try await dataSource.postWakeupSong(request)
    }
    
    public func postWakeupSongByKeyword(_ request: PostWakeupSongByKeywordRequest) async throws {
        try await dataSource.postWakeupSongByKeyword(request)
    }
    
    public func deleteWakeupSong(id: Int) async throws {
        try await dataSource.deleteWakeupSong(id: id)
    }
}
