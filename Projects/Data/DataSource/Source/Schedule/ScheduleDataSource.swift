//
//  ScheduleDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Network
import Domain

public struct ScheduleDataSource: DataSourceProtocol {
    let remote: ScheduleRemote
    
    public init(remote: ScheduleRemote) {
        self.remote = remote
    }
    
    public func fetchScheduleByPage(_ request: FetchScheduleByPageRequest) async throws -> [ScheduleResponse] {
        let response = try await remote.fetchScheduleByPage(request)
        return response.data
    }
    
    public func fetchTodaySchedule() async throws -> [ScheduleResponse] {
        let response = try await remote.fetchTodaySchedule()
        return response.data
    }
    
    public func fetchScheduleBetween(_ request: FetchScheduleBetweenRequest) async throws -> [ScheduleResponse] {
        let response = try await remote.fetchScheduleBetween(request)
        return response.data
    }
    
    public func fetchScheduleByKeyword(_ request: FetchScheduleByKeywordRequest) async throws -> [ScheduleResponse] {
        let response = try await remote.fetchScheduleByKeyword(request)
        return response.data
    }
    
    public func fetchScheduleByDate(_ request: FetchScheduleByDateRequest) async throws -> [ScheduleResponse] {
        let response = try await remote.fetchScheduleByDate(request)
        return response.data
    }
}
