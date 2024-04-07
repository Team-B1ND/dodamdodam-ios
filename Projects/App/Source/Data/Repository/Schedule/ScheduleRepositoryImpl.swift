//
//  ScheduleRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct ScheduleRepositoryImpl: ScheduleRepository {
    
    let dataSource: ScheduleDataSource
    
    func fetchScheduleByPage(_ request: FetchScheduleByPageRequest) async throws -> [ScheduleResponse] {
        try await dataSource.fetchScheduleByPage(request)
    }
    
    func fetchTodaySchedule() async throws -> [ScheduleResponse] {
        try await dataSource.fetchTodaySchedule()
    }
    
    func fetchScheduleBetween(_ request: FetchScheduleBetweenRequest) async throws -> [ScheduleResponse] {
        try await dataSource.fetchScheduleBetween(request)
    }
    
    func fetchScheduleByKeyword(_ request: FetchScheduleByKeywordRequest) async throws -> [ScheduleResponse] {
        try await dataSource.fetchScheduleByKeyword(request)
    }
    
    func fetchScheduleByDate(_ request: FetchScheduleByDateRequest) async throws -> [ScheduleResponse] {
        try await dataSource.fetchScheduleByDate(request)
    }
}
