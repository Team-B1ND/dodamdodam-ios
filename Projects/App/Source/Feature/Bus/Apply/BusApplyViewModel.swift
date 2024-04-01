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
    @Published var dialogMessage = "" {
        didSet {
            showDialog = true
        }
    }
    @Published var showDialog = false
    
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
            self.selectedBus = appliedBus
        } catch {
            print("\(#function)")
            print(error)
        }
    }
    
    @MainActor
    func completeBus() async {
        print("\(#function)")
        defer {
            Task {
                await fetchBuses()
                await fetchAppledBus()
            }
        }
        guard let selectedBus else {
            do {
                print("delete bus")
                try await busRepository.deleteAppliedBus(id: appliedBus?.id ?? 0)
                appliedBus = nil
                dialogMessage = "버스 삭제에 성공했어요"
            } catch {
                dialogMessage = "버스 삭제에 실패했어요"
                print(error)
            }
            return
        }
        guard let appliedBus else {
            print("post bus")
            do {
                try await busRepository.postApplyBus(id: selectedBus.id)
                self.appliedBus = selectedBus
                dialogMessage = "버스 신청에 성공했어요"
            } catch {
                dialogMessage = "버스 신청에 실패했어요"
                print(error)
            }
            return
        }
        guard selectedBus != appliedBus else {
            print("delete bus")
            do {
                try await busRepository.deleteAppliedBus(id: selectedBus.id)
                self.appliedBus = nil
                dialogMessage = "버스 삭제에 성공했어요"
            } catch {
                dialogMessage = "버스 삭제에 실패했어요"
                print(error)
            }
            return
        }
        guard selectedBus.applyCount < selectedBus.peopleLimit else {
            dialogMessage = "버스가 만석이에요"
            return
        }
        do {
            try await busRepository.patchAppliedBus(id: selectedBus.id)
            dialogMessage = "버스 변경에 성공했어요"
            self.appliedBus = selectedBus
        } catch {
            dialogMessage = "버스 변경에 실패했어요"
            print(error)
        }
        
    }
//    func
}
