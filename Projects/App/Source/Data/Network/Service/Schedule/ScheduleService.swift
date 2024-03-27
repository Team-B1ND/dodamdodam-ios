//
//  ScheduleService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation
import Moya

enum ScheduleService: ServiceProtocol {
    
    case fetchScheduleByPage(_ request: FetchScheduleByPageRequest)
    case fetchTodaySchedule
    case fetchScheduleBetween(_ request: FetchScheduleBetweenRequest)
    case fetchScheduleByKeyword(_ request: FetchScheduleByKeywordRequest)
    case fetchScheduleByDate(_ request: FetchScheduleByDateRequest)
}

extension ScheduleService {
    
    var baseURL: URL {
        host.appendingPathComponent("schedule")
    }
    
    var path: String {
        switch self {
        case .fetchScheduleByPage: ""
        case .fetchTodaySchedule: "/today"
        case .fetchScheduleBetween: "/search"
        case .fetchScheduleByKeyword: "/search/keyword"
        case .fetchScheduleByDate: "/date"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchScheduleByPage: .get
        case .fetchTodaySchedule: .get
        case .fetchScheduleBetween: .get
        case .fetchScheduleByKeyword: .get
        case .fetchScheduleByDate: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .fetchScheduleByPage(request):
            request.toURLParameters()
        case .fetchTodaySchedule:
                .requestPlain
        case let .fetchScheduleBetween(request):
            request.toURLParameters()
        case let .fetchScheduleByKeyword(request):
            request.toURLParameters()
        case let .fetchScheduleByDate(request):
            request.toURLParameters()
        }
    }
}
