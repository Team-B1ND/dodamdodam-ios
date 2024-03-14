//
//  AuthRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation

protocol AuthRepository {
    
    func login(_ request: LoginRequest) async -> Member
    func reissue(_ request: ReissueRequest) async
}
