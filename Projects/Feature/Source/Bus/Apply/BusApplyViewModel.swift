//
//  BusApplyViewModel.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import Foundation
import Domain
import DIContainer

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
            await deleteBus(id: appliedBus?.id ?? 0)
            return
        }
        guard let appliedBus else {
            await postBus(id: selectedBus.id)
            return
        }
        guard selectedBus != appliedBus else {
            await deleteBus(id: selectedBus.id)
            return
        }
        guard selectedBus.applyCount < selectedBus.peopleLimit else {
            dialogMessage = "버스가 만석이에요"
            return
        }
        await patchBus(id: selectedBus.id)
    }
    
    @MainActor
    private func postBus(id: Int) async {
        do {
            try await busRepository.postApplyBus(id: id)
            self.appliedBus = selectedBus
            dialogMessage = "버스 신청에 성공했어요"
        } catch {
            dialogMessage = "버스 신청에 실패했어요"
            print(error)
        }
    }
    
    @MainActor
    private func deleteBus(id: Int) async {
        do {
            try await busRepository.deleteAppliedBus(id: id)
            self.appliedBus = nil
            dialogMessage = "버스 삭제에 성공했어요"
        } catch {
            dialogMessage = "버스 삭제에 실패했어요"
            print(error)
        }
    }
    
    @MainActor
    private func patchBus(id: Int) async {
        do {
            try await busRepository.patchAppliedBus(id: id)
            dialogMessage = "버스 변경에 성공했어요"
            self.appliedBus = selectedBus
        } catch {
            dialogMessage = "버스 변경에 실패했어요"
            print(error)
        }
    }
}
