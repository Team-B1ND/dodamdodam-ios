//
//  MemberService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation
import Moya

enum MemberService: ServiceProtocol {
    
    case postJoin(_ request: PostJoinRequest)
    case patchPassword(_ request: PatchPasswordRequest)
    case patchMemberInfo(_ request: PatchMemberInfoRequest)
    case patchStudentInfo(_ request: PatchStudentInfoRequest)
    case fetchInfo
}

extension MemberService {
    
    var baseURL: URL {
        host.appendingPathComponent("member")
    }
    
    var path: String {
        switch self {
        case .postJoin: "/join-student"
        case .patchPassword: "/password"
        case .patchMemberInfo: "/info"
        case .patchStudentInfo: "/student/info"
        case .fetchInfo: "/my"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postJoin: .post
        case .patchPassword: .patch
        case .patchMemberInfo: .patch
        case .patchStudentInfo: .patch
        case .fetchInfo: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .postJoin(request):
            request.toJSONParameters()
        case let .patchPassword(request):
            request.toJSONParameters()
        case let .patchMemberInfo(request):
            request.toJSONParameters()
        case let .patchStudentInfo(request):
            request.toJSONParameters()
        case .fetchInfo:
                .requestPlain
        }
    }
}
