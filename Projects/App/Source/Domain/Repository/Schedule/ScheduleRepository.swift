//
//  ScheduleRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

protocol ScheduleRepository: RepositoryProtocol {
    
    func fetchScheduleByPage(_ request: FetchScheduleByPageRequest) async throws -> [ScheduleResponse]
    
    func fetchTodaySchedule() async throws -> [ScheduleResponse]
    
    func fetchScheduleBetween(_ request: FetchScheduleBetweenRequest) async throws -> [ScheduleResponse]
    
    func fetchScheduleByKeyword(_ request: FetchScheduleByKeywordRequest) async throws -> [ScheduleResponse]
    
    func fetchScheduleByDate(_ request: FetchScheduleByDateRequest) async throws -> [ScheduleResponse]
}
