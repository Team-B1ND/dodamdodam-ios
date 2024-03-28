//
//  BusRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

protocol BusRepository: RepositoryProtocol {
    
    func fetchAllBus() async throws -> [BusResponse]
    
    func fetchAppliedBus() async throws -> BusResponse
    
    func postApplyBus(id: Int) async throws
    
    func patchAppliedBus(id: Int) async throws
    
    func deleteAppliedBus(id: Int) async throws
}
