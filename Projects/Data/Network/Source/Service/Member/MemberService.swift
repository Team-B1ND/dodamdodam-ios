//
//  MemberService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Moya
import Domain

enum MemberService: ServiceProtocol {
    
    case postJoinStudent(_ request: PostJoinStudentRequest)
    case postJoinParent(_ request: PostJoinParentRequest)
    case postAuthCode(type: AuthType, _ request: PostAuthCodeRequest)
    case postVerifyAuthCode(type: AuthType, _ request: PostVerifyAuthCodeRequest)
    case patchDeactivate
    case patchPassword(_ request: PatchPasswordRequest)
    case patchMemberInfo(_ request: PatchMemberInfoRequest)
    case patchStudentInfo(_ request: PatchStudentInfoRequest)
    case fetchInfo
}

extension MemberService {
    
    var host: String {
        "member"
    }
    
    var path: String {
        switch self {
        case .postJoinStudent: "/join-student"
        case .postJoinParent: "/join-parent"
        case let .postAuthCode(type, _): "/auth-code/\(type.rawValue)"
        case let .postVerifyAuthCode(type, _): "/auth-code/\(type.rawValue)/verify"
        case .patchDeactivate: "/deactivate"
        case .patchPassword: "/password"
        case .patchMemberInfo: "/info"
        case .patchStudentInfo: "/student/info"
        case .fetchInfo: "/my"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postJoinStudent: .post
        case .postJoinParent: .post
        case .postAuthCode: .post
        case .postVerifyAuthCode: .post
        case .patchDeactivate: .patch
        case .patchPassword: .patch
        case .patchMemberInfo: .patch
        case .patchStudentInfo: .patch
        case .fetchInfo: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .postJoinStudent(request):
            request.toJSONParameters()
        case let .postJoinParent(request):
            request.toJSONParameters()
        case let .postAuthCode(_, request):
            request.toJSONParameters()
        case let .postVerifyAuthCode(_, request):
            request.toJSONParameters()
        case .patchDeactivate:
                .requestPlain
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
