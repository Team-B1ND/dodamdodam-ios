//
//  BusRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

public protocol BusRepository: RepositoryProtocol {
    
    func fetchAllBus() async throws -> [BusResponse]
    
    func fetchAppliedBus() async throws -> BusResponse?
    
    func fetchBusSeats(id: Int) async throws -> BusSeatResponse
    
    func fetchQrCode() async throws -> BusQrCodeResponse
    
    func patchBusStatus(id: Int, seatNumber: Int) async throws
}
