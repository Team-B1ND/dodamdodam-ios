//
//  LoginResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//
public struct LoginResponse: ResponseProtocol {
    
    public let member: Member
    public let refreshToken: String
    public let accessToken: String
    
    public init(member: Member, refreshToken: String, accessToken: String) {
        self.member = member
        self.refreshToken = refreshToken
        self.accessToken = accessToken
    }
}
