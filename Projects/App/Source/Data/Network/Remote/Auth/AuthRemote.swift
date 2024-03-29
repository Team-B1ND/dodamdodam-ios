//
//  AuthRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct AuthRemote: RemoteProtocol {
    
    typealias Target = AuthService
    
    func postLogin(_ request: PostLoginRequest) async throws -> Response<LoginResponse> {
        try await self.request(target: .postLogin(request))
            .map(Response<LoginResponse>.self, using: decoder)
    }
    
    func postReissue(_ request: PostReissueRequest) async throws -> Response<ReissueResponse> {
        try await self.request(target: .postReissue(request))
            .map(Response<ReissueResponse>.self, using: decoder)
    }
}
