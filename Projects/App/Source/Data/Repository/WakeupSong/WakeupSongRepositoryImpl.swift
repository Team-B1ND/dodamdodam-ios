//
//  WakeupSongRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct WakeupSongRepositoryImpl: WakeupSongRepository {
    
    let dataSource: WakeupSongDataSource
    
    func fetchWakeupSong() async throws -> [WakeupSongResponse] {
        try await dataSource.fetchWakeupSong()
    }
    
    func fetchAllowedWakeupSong(_ request: FetchAllowedWakeupSongRequest) async throws -> [WakeupSongResponse] {
        try await dataSource.fetchAllowedWakeupSong(request)
    }
    
    func fetchPendingWakeupSong() async throws -> [WakeupSongResponse] {
        try await dataSource.fetchPendingWakeupSong()
    }
    
    func fetchWakeupSongChart() async throws -> [WakeupSongChartResponse] {
        try await dataSource.fetchWakeupSongChart()
    }
    
    func postWakeupSong(_ request: PostWakeupSongRequest) async throws {
        try await dataSource.postWakeupSong(request)
    }
    
    func postWakeupSongByKeyword(_ request: PostWakeupSongByKeywordRequest) async throws {
        try await dataSource.postWakeupSongByKeyword(request)
    }
    
    func deleteWakeupSong(id: Int) async throws {
        try await dataSource.deleteWakeupSong(id: id)
    }
}
