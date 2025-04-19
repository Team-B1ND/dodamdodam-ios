//
//  BusApplySelectSeatViewModel.swift
//  Feature
//
//  Created by hhhello0507 on 3/10/25.
//

import Foundation
import Domain
import DIContainer

final class BusApplySelectSeatViewModel: ObservableObject, OnAppearProtocol {
    
    // MARK: - State
    @Published var seatNumber: Int?
    @Published var busSeats: BusSeatResponse?
    @Published var isLoading: Bool = true
    private let busId: Int
    
    var isFirstOnAppear: Bool = true
    // MARK: - Repository
    @Inject var busRepository: any BusRepository
    
    // MARK: - Method
    init(busId: Int) {
        self.busId = busId
    }
    
    @MainActor
    func patchStatus(completion: @escaping () -> Void) async {
        guard let seatNumber else { return }
        
        do {
            try await busRepository.patchBusStatus(id: busId, seatNumber: seatNumber)
            completion()
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func applyBus(completion: @escaping () -> Void) async {
        guard let seatNumber else { return }
        
        do {
            try await busRepository.applyBus(id: busId, seatNumber: seatNumber)
            completion()
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func fetchBusSeat() async {
        do {
            busSeats = try await busRepository.fetchBusSeats(id: busId)
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func isReserved(seatNumber: Int) -> Bool {
        return busSeats?.busSeat.contains(seatNumber) ?? false
    }
    
    @MainActor
    func fetchAllData() async {
        isLoading = true
        async let fetchBusSeat: () = fetchBusSeat()
        _ = await fetchBusSeat
        isLoading = false
    }
}
