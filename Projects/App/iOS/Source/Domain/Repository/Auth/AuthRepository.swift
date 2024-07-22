//
//  AuthRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

protocol AuthRepository: RepositoryProtocol {
    
    func postLogin(_ request: PostLoginRequest) async throws -> Member
    
    func postReissue(_ request: PostReissueRequest) async throws
}
