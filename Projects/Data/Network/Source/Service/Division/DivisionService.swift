//
//  DivisionService.swift
//  Repository
//
//  Created by hhhello0507 on 2/4/25.
//

import Moya
import Domain

enum DivisionService: ServiceProtocol {
    
    case createDivision(_ request: PostDivisionRequest)
    case applyMemberDivision(id: Int)
    case addMembers(id: Int, request: AddMembersRequest)
    case patchDivision(_ request: PostDivisionRequest)
    case patchMemberStatus(id: Int, request: PatchMembersStatusRequest)
    case deleteDivision(id: Int)
    case deleteMembers(id: Int, request: DeleteDivisionMembersRequest)
    case fetchDivisions(request: FetchDivisionRequest)
    case fetchDivision(id: Int)
    case fetchMyDivision(request: FetchDivisionRequest)
    case fetchDivisionMembers(id: Int, request: FetchDivisionMembersRequest)
    case fetchDivisionMembersCount(id: Int, request: FetchDivisionMembersRequest)
}

extension DivisionService {
    
    var host: String {
        "divisions"
    }
    
    var path: String {
        switch self {
        case .createDivision: ""
        case .applyMemberDivision(let id): "/\(id)/members/apply"
        case .addMembers(let id, _): "/\(id)/members"
        case .patchDivision(let id): "/\(id)"
        case .patchMemberStatus(let id, _): "/\(id)/members"
        case .deleteDivision(let id): "/\(id)"
        case .deleteMembers(let id, _): "/\(id)/members"
        case .fetchDivisions: ""
        case .fetchDivision(let id): "/\(id)"
        case .fetchMyDivision: "/my"
        case .fetchDivisionMembers(let id, _): "/\(id)/members"
        case .fetchDivisionMembersCount(let id, _): "/\(id)/members/count"
        }
    }
    
    var method: Method {
        switch self {
        case .createDivision: .post
        case .applyMemberDivision: .post
        case .addMembers: .post
        case .patchDivision: .patch
        case .patchMemberStatus: .patch
        case .deleteDivision: .delete
        case .deleteMembers: .delete
        case .fetchDivisions: .get
        case .fetchDivision: .get
        case .fetchMyDivision: .get
        case .fetchDivisionMembers: .get
        case .fetchDivisionMembersCount: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createDivision(let request):
            request.toJSONParameters()
        case .applyMemberDivision:
                .requestPlain
        case .addMembers(_, let request):
            request.toURLParameters()
        case .patchDivision(let request):
            request.toJSONParameters()
        case .patchMemberStatus(let id, let request):
            request.toURLParameters()
        case .deleteDivision:
                .requestPlain
        case .deleteMembers(let id, let request):
            request.toURLParameters()
        case .fetchDivisions(let request):
            request.toURLParameters()
        case .fetchDivision:
                .requestPlain
        case .fetchMyDivision(let request):
            request.toURLParameters()
        case .fetchDivisionMembers(let id, let request):
            request.toURLParameters()
        case .fetchDivisionMembersCount(let id, let request):
            request.toURLParameters()
        }
    }
}
