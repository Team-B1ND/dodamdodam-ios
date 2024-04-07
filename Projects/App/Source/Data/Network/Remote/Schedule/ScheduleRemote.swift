//
//  ScheduleRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct ScheduleRemote: RemoteProtocol {
    
    typealias Target = ScheduleService
    
    func fetchScheduleByPage(_ request: FetchScheduleByPageRequest) async throws -> Response<[ScheduleResponse]> {
        try await self.request(target: .fetchScheduleByPage(request))
            .map(Response<[ScheduleResponse]>.self, using: decoder)
    }
    
    func fetchTodaySchedule() async throws -> Response<[ScheduleResponse]> {
        try await self.request(target: .fetchTodaySchedule)
            .map(Response<[ScheduleResponse]>.self, using: decoder)
    }
    
    func fetchScheduleBetween(_ request: FetchScheduleBetweenRequest) async throws -> Response<[ScheduleResponse]> {
        try await self.request(target: .fetchScheduleBetween(request))
            .map(Response<[ScheduleResponse]>.self, using: decoder)
    }
    
    func fetchScheduleByKeyword(_ request: FetchScheduleByKeywordRequest) async throws -> Response<[ScheduleResponse]> {
        try await self.request(target: .fetchScheduleByKeyword(request))
            .map(Response<[ScheduleResponse]>.self, using: decoder)
    }
    
    func fetchScheduleByDate(_ request: FetchScheduleByDateRequest) async throws -> Response<[ScheduleResponse]> {
        try await self.request(target: .fetchScheduleByDate(request))
            .map(Response<[ScheduleResponse]>.self, using: decoder)
    }
}
