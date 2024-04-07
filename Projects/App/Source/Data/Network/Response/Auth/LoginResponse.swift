//
//  LoginResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct LoginResponse: ResponseProtocol {
    
    let member: Member
    let refreshToken: String
    let accessToken: String
}
