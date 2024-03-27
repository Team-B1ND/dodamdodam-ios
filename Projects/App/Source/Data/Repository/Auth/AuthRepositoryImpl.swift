//
//  AuthRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation

struct AuthRepositoryImpl: AuthRepository {
    
    public func postLogin(_ request: PostLoginRequest) async throws -> Member {
        // TODO: TOKEN LOGIC
        return authDataSource.signIn(request)
            .flatMap { response -> Single<Void> in
                KeychainService.username = request.id
                KeychainService.password = request.pw
                AuthController.getInstance().signIn(token: response.data.token!, refreshToken: response.data.refreshToken!)
                return .just(Void())
            }
    }
    
    public func postReissue(_ request: PostReissueRequest) async throws {
        // TODO: REISSUE LOGIC
        return authDataSource.signUp(request)
    }
}
