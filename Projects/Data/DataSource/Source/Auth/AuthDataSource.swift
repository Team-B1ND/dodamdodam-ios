//
//  AuthDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain
import Network
import SwiftBok

@Init()
public struct AuthDataSource: DataSourceProtocol {
    
    let remote: AuthRemote
    
    public func postLogin(_ request: PostLoginRequest) async throws -> LoginResponse {
        let response = try await remote.postLogin(request)
        return response.data
    }
    
    public func postReissue(_ request: PostReissueRequest) async throws -> ReissueResponse {
        let response = try await remote.postReissue(request)
        return response.data
    }
}
