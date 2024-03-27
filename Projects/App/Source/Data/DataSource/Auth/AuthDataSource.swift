//
//  AuthDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Moya

struct AuthDataSource {
    
    let remote: AuthRemote
    
    func postLogin(_ request: PostLoginRequest) async throws -> Response<LoginResponse> {
        try await remote.postLogin(request)
    }
    
    func postReissue(_ request: PostReissueRequest) async throws -> Response<ReissueResponse> {
        try await remote.postReissue(request)
    }
}
