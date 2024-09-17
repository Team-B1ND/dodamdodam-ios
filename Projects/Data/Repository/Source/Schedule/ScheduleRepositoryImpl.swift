//
//  ScheduleRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import DataSource

public struct ScheduleRepositoryImpl: ScheduleRepository {
    
    let dataSource: ScheduleDataSource
    
    public init(dataSource: ScheduleDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchScheduleByPage(_ request: FetchScheduleByPageRequest) async throws -> [ScheduleResponse] {
        try await dataSource.fetchScheduleByPage(request)
    }
    
    public func fetchTodaySchedule() async throws -> [ScheduleResponse] {
        try await dataSource.fetchTodaySchedule()
    }
    
    public func fetchScheduleBetween(_ request: FetchScheduleBetweenRequest) async throws -> [ScheduleResponse] {
        try await dataSource.fetchScheduleBetween(request)
    }
    
    public func fetchScheduleByKeyword(_ request: FetchScheduleByKeywordRequest) async throws -> [ScheduleResponse] {
        try await dataSource.fetchScheduleByKeyword(request)
    }
    
    public func fetchScheduleByDate(_ request: FetchScheduleByDateRequest) async throws -> [ScheduleResponse] {
        try await dataSource.fetchScheduleByDate(request)
    }
}
