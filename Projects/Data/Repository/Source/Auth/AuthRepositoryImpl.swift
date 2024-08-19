//
//  AuthRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import SignKit
import DataSource
import Domain
import SwiftBok

@Init()
public struct AuthRepositoryImpl: AuthRepository {
    
    let dataSource: AuthDataSource
    
    public func postLogin(_ request: PostLoginRequest) async throws -> Member {
        let data = try await dataSource.postLogin(request)
        Sign.login(
            id: request.id,
            password: request.pw,
            accessToken: data.accessToken,
            refreshToken: data.refreshToken
        )
        return data.member
    }
    
    public func postReissue(_ request: PostReissueRequest) async throws {
        let data = try await dataSource.postReissue(request)
        Sign.reissue(data.accessToken)
    }
}
