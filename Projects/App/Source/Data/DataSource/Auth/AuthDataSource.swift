//
//  AuthDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Moya

struct AuthDataSource {
    
    let remote: AuthRemote
    
    func login(_ request: LoginRequest) async -> Response<LoginResponse> {
        remote.login(request)
    }
    
    func signUp(_ request: SignUpRequest) -> Single<Void> {
        remote.postSignUp(request)
    }
}
