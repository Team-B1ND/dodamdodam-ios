//
//  BusRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import DataSource
import Domain

public struct BusRepositoryImpl: BusRepository {
    
    let dataSource: BusDataSource
    
    public init(dataSource: BusDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchAllBus() async throws -> [BusResponse] {
        try await dataSource.fetchAllBus()
    }
    
    public func fetchAppliedBus() async throws -> BusResponse? {
        try await dataSource.fetchAppliedBus()
    }
    
    public func fetchBusSeats(id: Int) async throws -> BusSeatResponse {
        try await dataSource.fetchBusSeats(id: id)
    }
    
    public func fetchQrCode() async throws -> BusQrCodeResponse {
        try await dataSource.fetchQrCode()
    }
    
    public func patchBusStatus(id: Int, seatNumber: Int) async throws {
        try await dataSource.patchBusStatus(id: id, seatNumber: seatNumber)
    }
    
    public func applyBus(id: Int, seatNumber: Int) async throws {
        try await dataSource.applyBus(id: id, seatNumber: seatNumber)
    }
}
