//
//  LoginResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation

struct LoginResponse: ResponseProtocol {
    
    let memeber: Member
    let refreshToken: String
    let accessToken: String
}
