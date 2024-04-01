//
//  BusApplyViewModel.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import Foundation

class BusApplyViewModel: ObservableObject {
    
    // MARK: - State
    @Published var buses: [BusResponse] = []
    @Published var appliedBus: BusResponse?
    @Published var showNotFoundBus = false
    
    // MARK: - Repository
    @Inject var busRepository: any BusRepository
    
    // MARK: - Method
    @MainActor
    func fetchBuses() async {
        do {
            buses = try await busRepository.fetchAllBus()
            if buses.isEmpty {
                showNotFoundBus = true
            }
        } catch {
            debugPrint(error)
        }
    }
    
    @MainActor
    func fetchAppledBus() async {
        do {
            appliedBus = try await busRepository.fetchAppliedBus()
        } catch {
            print("\(#function)")
            print(error)
        }
    }
//    func
}
