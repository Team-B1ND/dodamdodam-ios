//
//  LoginResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import SwiftBok

@Init()
@Members()
public struct LoginResponse: ResponseProtocol {
    
    public let member: Member
    public let refreshToken: String
    public let accessToken: String
}
