//
//  BusDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Network
import Domain

public struct BusDataSource: DataSourceProtocol {
    let remote: BusRemote
    
    public init(remote: BusRemote) {
        self.remote = remote
    }
    
    public func fetchAllBus() async throws -> [BusResponse] {
        let response = try await remote.fetchAllBus()
        return response.data
    }
    
    public func fetchAppliedBus() async throws -> BusResponse? {
        let response = try await remote.fetchAppliedBus()
        return response.data
    }
    
    public func fetchBusSeats(id: Int) async throws -> BusSeatResponse {
        let response = try await remote.fetchBusSeats(id: id)
        return response.data
    }
    
    public func fetchQrCode() async throws -> BusQrCodeResponse {
        let response = try await remote.fetchQrCode()
        return response.data
    }
    
    public func patchBusStatus(id: Int, seatNumber: Int) async throws {
        _ = try await remote.patchBusStatus(id: id, seatNumber: seatNumber)
    }
}
