//
//  NoticeService.swift
//  Repository
//
//  Created by dgsw8th61 on 2/6/25.
//

import Moya
import Domain

enum NoticeService: ServiceProtocol {
    
    case fetchNotice(_ request: FetchNoticeRequest)
    case fetchNoticeDivision(_ request: FetchNoticeByDivisionRequest)
}

extension NoticeService {
    
    var host: String {
        "notice"
    }
    
    var path: String {
        switch self {
        case .fetchNotice: ""
        case .fetchNoticeDivision: "/division"
        }
    }
    
    var method: Method {
        switch self {
        case .fetchNotice: .get
        case .fetchNoticeDivision: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .fetchNotice(request):
            request.toURLParameters()
        case let .fetchNoticeDivision(request):
            request.toURLParameters()
        }
    }
}
