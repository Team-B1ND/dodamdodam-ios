//
//  AuthRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation

struct AuthRepositoryImpl: AuthRepository {

    public func signIn(_ request: SignInRequest) -> Single<Void> {
        return authDataSource.signIn(request)
            .flatMap { response -> Single<Void> in
                KeychainService.username = request.id
                KeychainService.password = request.pw
                AuthController.getInstance().signIn(token: response.data.token!, refreshToken: response.data.refreshToken!)
                return .just(Void())
            }
    }

    public func signUp(_ request: SignUpRequest) -> Single<Void> {
        return authDataSource.signUp(request)
    }
}
