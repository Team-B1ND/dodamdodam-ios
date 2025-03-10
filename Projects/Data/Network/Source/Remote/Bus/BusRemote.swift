//
//  BusRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation
import Domain

public struct BusRemote: RemoteProtocol {
    typealias Target = BusService
    
    public init() {}
    
    public func fetchAllBus() async throws -> Response<[BusResponse]> {
        try await self.request(target: .fetchAllBus, res: [BusResponse].self)
    }
    
    public func fetchAppliedBus() async throws -> Response<BusResponse?> {
        try await self.request(target: .fetchAppliedBus, res: BusResponse?.self)
    }
    
    public func fetchBusSeats(id: Int) async throws -> Response<BusSeatResponse> {
        try await self.request(target: .fetchBusSeats(id: id), res: BusSeatResponse.self)
    }
    
    public func fetchQrCode() async throws -> Response<BusQrCodeResponse> {
        try await self.request(target: .fetchQrCode, res: BusQrCodeResponse.self)
    }
    
    public func patchBusStatus(id: Int, seatNumber: Int) async throws -> DefaultResponse {
        try await self.request(target: .patchBusStatus(id: id, seatNumber: seatNumber))
    }
}
