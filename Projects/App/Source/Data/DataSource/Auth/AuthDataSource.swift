//
//  AuthDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct AuthDataSource: DataSourceProtocol {
    
    let remote: AuthRemote
    
    func postLogin(_ request: PostLoginRequest) async throws -> LoginResponse {
        let response = try await remote.postLogin(request)
        return response.data
    }
    
    func postReissue(_ request: PostReissueRequest) async throws -> ReissueResponse {
        let response = try await remote.postReissue(request)
        return response.data
    }
}
