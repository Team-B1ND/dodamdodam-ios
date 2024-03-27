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
    case fetchInfo(
}

extension MemberService {
    
    var baseURL: URL {
        host.appendingPathComponent("meal")
    }
    
    var path: String {
        switch self {
        }
    }
    
    var method: Moya.Method {
        switch self {
        }
    }
    
    var task: Moya.Task {
        switch self {
        }
    }
}
