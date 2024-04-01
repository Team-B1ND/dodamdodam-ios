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
    @Published var selectedBus: BusResponse?
    @Published var showNotFoundBus = false
    @Published var dialogMessage = ""
    
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
            print("\(#function)")
            print(error)
        }
    }
    
    @MainActor
    func fetchAppledBus() async {
        do {
            appliedBus = try await busRepository.fetchAppliedBus()
            selectedBus = appliedBus
        } catch {
            print("\(#function)")
            print(error)
        }
    }
    
    @MainActor
    func completeBus() async {
        do {
            guard let selectedBus else {
                try await busRepository.deleteAppliedBus(id: appliedBus?.id ?? 0)
                return
            }
            guard let appliedBus else {
                try await busRepository.postApplyBus(id: selectedBus.id)
                return
            }
            guard selectedBus != appliedBus else {
                // handle already applied this bus
                return
            }
            try await busRepository.patchAppliedBus(id: selectedBus.id)
        } catch {
            print("\(#function)")
            print(error)
        }
    }
//    func
}
