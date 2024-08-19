//
//  ScheduleRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import SwiftBok

@Init()
public struct ScheduleRemote: RemoteProtocol {
    
    typealias Target = ScheduleService
    
    public func fetchScheduleByPage(_ request: FetchScheduleByPageRequest) async throws -> Response<[ScheduleResponse]> {
        try await self.request(target: .fetchScheduleByPage(request), res: [ScheduleResponse].self)
    }
    
    public func fetchTodaySchedule() async throws -> Response<[ScheduleResponse]> {
        try await self.request(target: .fetchTodaySchedule, res: [ScheduleResponse].self)
    }
    
    public func fetchScheduleBetween(_ request: FetchScheduleBetweenRequest) async throws -> Response<[ScheduleResponse]> {
        try await self.request(target: .fetchScheduleBetween(request), res: [ScheduleResponse].self)
    }
    
    public func fetchScheduleByKeyword(_ request: FetchScheduleByKeywordRequest) async throws -> Response<[ScheduleResponse]> {
        try await self.request(target: .fetchScheduleByKeyword(request), res: [ScheduleResponse].self)
    }
    
    public func fetchScheduleByDate(_ request: FetchScheduleByDateRequest) async throws -> Response<[ScheduleResponse]> {
        try await self.request(target: .fetchScheduleByDate(request), res: [ScheduleResponse].self)
    }
}
