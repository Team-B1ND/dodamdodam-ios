//
//  WakeupSongRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

public protocol WakeupSongRepository: RepositoryProtocol {
    
    func fetchWakeupSong() async throws -> [WakeupSongResponse]
    
    func fetchAllowedWakeupSong(_ request: FetchAllowedWakeupSongRequest) async throws -> [WakeupSongResponse]
    
    func fetchPendingWakeupSong() async throws -> [WakeupSongResponse]
    
    func fetchWakeupSongChart() async throws -> [WakeupSongChartResponse]
    
    func fetchWakeupSongByKeyword(
        _ request: FetchWakeupSongByKeywordRequest
    ) async throws -> [WakeupSongSearchResponse]
    
    func postWakeupSong(_ request: PostWakeupSongRequest) async throws
    
    func postWakeupSongByKeyword(_ request: PostWakeupSongByKeywordRequest) async throws
    
    func deleteWakeupSong(id: Int) async throws
}
