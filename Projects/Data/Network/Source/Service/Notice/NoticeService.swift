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
    case fetchCategoryNotice(id: Int, _ request: FetchCategoryNoticeRequest)
}

extension NoticeService {
    
    var host: String {
        "notice"
    }
    
    var path: String {
        switch self {
        case .fetchNotice: ""
        case .fetchCategoryNotice(let id, _): "/\(id)"
        }
    }
    
    var method: Method {
        switch self {
        case .fetchNotice: .get
        case .fetchCategoryNotice: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .fetchNotice(request):
            request.toURLParameters()
        case let .fetchCategoryNotice(_, request):
            request.toURLParameters()
        }
    }
}

