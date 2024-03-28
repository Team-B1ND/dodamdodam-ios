//
//  OutGoingRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

protocol OutGoingRepository {
    
    func postOutGoing(_ request: PostOutGoingRequest) async throws
    
    func deleteOutGoing(id: Int) async throws
    
    func fetchOutGoing() async throws -> [OutGoingResponse]
}
