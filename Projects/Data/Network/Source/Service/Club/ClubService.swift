//
//  ClubService.swift
//  Repository
//
//  Created by dgsw30 on 2/25/25.
//

import Moya
import Domain

enum ClubService: ServiceProtocol {
    case fetchClub
    case fetchClubMembers(id: Int)
    case fetchAllClubMembers(id: Int)
    case fetchClubDetail(id: Int)
    case fetchClubJoinRequests
    case acceptJoinRequest(id: Int)
    case rejectJoinRequest(id: Int)
}

extension ClubService {
    var host: String {
        "clubs"
    }
    
    var path: String {
        switch self {
        case .fetchClub: ""
        case .fetchClubMembers(let id): "/\(id)/members"
        case .fetchAllClubMembers(let id): "/\(id)/all-members"
        case .fetchClubDetail(let id): "/\(id)"
        case .fetchClubJoinRequests: "/join-requests/received"
        case .acceptJoinRequest(let id), .rejectJoinRequest(let id): "/join-requests/\(id)"
        }
    }
    
    var method: Method {
        switch self {
        case .fetchClub: .get
        case .fetchClubMembers(let id): .get
        case .fetchAllClubMembers(let id): .get
        case .fetchClubDetail(let id): .get
        case .fetchClubJoinRequests: .get
        case .acceptJoinRequest: .post
        case .rejectJoinRequest: .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchClub,
             .fetchClubMembers,
             .fetchAllClubMembers,
             .fetchClubDetail,
             .fetchClubJoinRequests,
             .acceptJoinRequest,
             .rejectJoinRequest:
            return .requestPlain
        }
    }
}
