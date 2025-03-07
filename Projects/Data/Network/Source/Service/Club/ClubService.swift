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
    case fetchCreativeClubs
    case fetchFreeClubs
    case fetchClubMembers(id: Int)
    case fetchClubDetail(id: Int)
    case fetchClubJoinRequests
    case acceptJoinRequest(id: Int)
    case rejectJoinRequest(id: Int)
    case applyToClub(request: [ClubApplyRequest])
    case fetchJoinedClubs
    case fetchMyClubs
    case fetchMyApplyClubs
    case fetchClubRegisterTime
}

extension ClubService {
    var host: String {
        "clubs"
    }
    
    var path: String {
        switch self {
        case .fetchClub: ""
        case .fetchCreativeClubs: ""
        case .fetchFreeClubs: ""
        case .fetchClubMembers(let id): "/\(id)/members"
        case .fetchClubDetail(let id): "/\(id)"
        case .fetchClubJoinRequests: "/join-requests/received"
        case .acceptJoinRequest(let id), .rejectJoinRequest(let id): "/join-requests/\(id)"
        case .applyToClub: "/join-requests"
        case .fetchJoinedClubs: "/joined"
        case .fetchMyClubs: "/my"   
        case .fetchMyApplyClubs: "/my/join-requests"
        case .fetchClubRegisterTime: "/time"
        }
    }
    
    var method: Method {
        switch self {
        case .fetchClub, .fetchCreativeClubs, .fetchFreeClubs,
             .fetchClubMembers,
             .fetchClubDetail, .fetchClubJoinRequests, .fetchJoinedClubs,
             .fetchMyClubs, .fetchMyApplyClubs, .fetchClubRegisterTime:
            return .get
        case .acceptJoinRequest, .applyToClub:
            return .post
        case .rejectJoinRequest:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchClub, .fetchCreativeClubs, .fetchFreeClubs,
             .fetchClubMembers,
             .fetchClubDetail, .fetchClubJoinRequests,
             .acceptJoinRequest, .rejectJoinRequest, .fetchJoinedClubs,
             .fetchMyClubs, .fetchMyApplyClubs, .fetchClubRegisterTime:
            return .requestPlain
            
        case .applyToClub(let request):
            return .requestJSONEncodable(request)
        }
    }
}
