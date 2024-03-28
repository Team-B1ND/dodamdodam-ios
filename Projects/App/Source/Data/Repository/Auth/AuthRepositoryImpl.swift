//
//  AuthRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct AuthRepositoryImpl: AuthRepository {
    
    let dataSource: AuthDataSource
    
    func postLogin(_ request: PostLoginRequest) async throws -> Member {
        let data = try await dataSource.postLogin(request)
        // TODO: Login
        return data.memeber
    }
    
    func postReissue(_ request: PostReissueRequest) async throws {
        _ = try await dataSource.postReissue(request)
        // TODO: Refresh
    }
}
