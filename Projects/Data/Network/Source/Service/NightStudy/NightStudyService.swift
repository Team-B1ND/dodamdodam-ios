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
    case searchStudents(query: String)
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
        case .postNightStudy: "/\(host)"
        case let .deleteNightStudy(id): "/\(host)/\(id)"
        case .fetchNightStudy: "/\(host)/my"
        case .checkBanStatus: "/\(host)/ban"
        case .searchStudents: "/\(host)/student/search"
        case .postNightStudyProject: "/\(host)/project"
        case .fetchNightStudyProject: "/\(host)/project/my"
        case .deleteNightStudyProject: "/\(host)/project"
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
        case let .searchStudents(query):
            .requestParameters(parameters: ["query": query], encoding: URLEncoding())
        case let .postNightStudyProject(request):
            request.toJSONParameters()
        case .fetchNightStudyProject:
            .requestPlain
        case let .deleteNightStudyProject(id):
            .requestParameters(parameters: ["project": id], encoding: URLEncoding())
        }
    }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        .successCodes
    }
}
