//
//  AuthRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation

struct AuthRemote: RemoteProtocol {
    
    typealias Target = AuthService
    
    func login(_ request: LoginRequest) async -> Response<LoginResponse> {
        return self.request(.postSignIn(request))
            .map(Response<SignInData>.self, using: decoder)
    }
    
    func reissue(_ request: ReissueRequest) async {
        return self.request(.postSignUp(request))
            .map { _ in Void() }
    }
}
