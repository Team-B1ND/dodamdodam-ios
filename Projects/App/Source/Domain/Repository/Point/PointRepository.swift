//
//  PointRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

protocol PointRepository: RepositoryProtocol {
    
    func fetchPoint(_ request: FetchPointRequest) async throws -> [PointResponse]
    
    func fetchPointScore(_ request: FetchPointScoreRequest) async throws -> [PointScoreResponse]
}
