//
//  AuthDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct AuthDataSource: DataSourceProtocol {
    
    let remote: AuthRemote
    
    func postLogin(_ request: PostLoginRequest) async throws -> Member {
        let response = try await remote.postLogin(request)
        return response.data.memeber
    }
    
    func postReissue(_ request: PostReissueRequest) async throws -> Response<ReissueResponse> {
        try await remote.postReissue(request)
    }
}
