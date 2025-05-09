//
//  NightStudyService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import Moya

enum NightStudyService: ServiceProtocol {
    case postNightStudy(_ request: PostNightStudyRequest)
    case deleteNightStudy(id: Int)
    case fetchNightStudy
    case checkBanStatus
    case searchStudents
    case postNightStudyProject(_ request: PostNightStudyProjectRequest)
    case fetchNightStudyProject
    case deleteNightStudyProject(id: Int)
}

extension NightStudyService {
    var host: String {
        "night-study"
    }
    
    var path: String {
        switch self {
        case .postNightStudy: ""
        case let .deleteNightStudy(id): "/\(id)"
        case .fetchNightStudy: "/my"
        case .checkBanStatus: "/ban/my"
        case .searchStudents: "/students"
        case .postNightStudyProject: "/project"
        case .fetchNightStudyProject: "/project/my"
        case let .deleteNightStudyProject(id): "/project/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postNightStudy: .post
        case .deleteNightStudy: .delete
        case .fetchNightStudy: .get
        case .checkBanStatus: .get
        case .searchStudents: .get
        case .postNightStudyProject: .post
        case .fetchNightStudyProject: .get
        case .deleteNightStudyProject: .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .postNightStudy(request):
            request.toJSONParameters()
        case .deleteNightStudy:
                .requestPlain
        case .fetchNightStudy:
                .requestPlain
        case .checkBanStatus:
                .requestPlain
        case .searchStudents:
                .requestPlain
        case let .postNightStudyProject(request):
            request.toJSONParameters()
        case .fetchNightStudyProject:
                .requestPlain
        case .deleteNightStudyProject:
                .requestPlain
        }
    }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
}
