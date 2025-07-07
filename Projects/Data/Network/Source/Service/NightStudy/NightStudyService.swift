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
    
    //MARK: 자치위원 기능
    case fetchPendingNightStudy
    case fetchApproveNightStudy
    case allowNightStudy(id: Int)
    case rejectNightStudy(id: Int)
    case banNightStudy(_ requset: NightStudyBanRequest)
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
            
            //MARK: 자치위원 기능
        case .fetchPendingNightStudy: "/pending"
        case .fetchApproveNightStudy: ""
        case let .allowNightStudy(id): "/\(id)/allow"
        case let .rejectNightStudy(id): "/\(id)/reject"
        case .banNightStudy: "/ban"
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
            
            //MARK: 자치위원 기능
        case .fetchPendingNightStudy: .get
        case .fetchApproveNightStudy: .get
        case .allowNightStudy: .patch
        case .rejectNightStudy: .patch
        case .banNightStudy: .post
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
            
            //MARK: 자치위원 기능
        case .fetchPendingNightStudy:
                .requestPlain
        case .fetchApproveNightStudy:
                .requestPlain
        case .allowNightStudy:
                .requestPlain
        case .rejectNightStudy:
                .requestPlain
        case let .banNightStudy(request):
            request.toJSONParameters()
        }
    }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
}
