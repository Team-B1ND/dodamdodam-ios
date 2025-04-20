//
//  BusApplyViewModel.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import Foundation
import Domain
import DIContainer

let dummyBus: [BusResponse] = [
    .init(
        id: 0,
        busName: "동대구역 1",
        description: "동대구역에 도착하는 버스입니다.",
        peopleLimit: 35,
        status: .activate,
        applyCount: 10,
        leaveTime: .now,
        timeRequired: .now
    ),
    .init(
        id: 1,
        busName: "동대구역 2",
        description: "동대구역에 도착하는 버스입니다.",
        peopleLimit: 35,
        status: .activate,
        applyCount: 8,
        leaveTime: .now,
        timeRequired: .now
    ),
    .init(
        id: 2,
        busName: "동대구역 3",
        description: "동대구역에 도착하는 버스입니다.",
        peopleLimit: 35,
        status: .deactivate,
        applyCount: 8,
        leaveTime: .now,
        timeRequired: .now
    )
]

class BusApplyViewModel: ObservableObject {
    
    // MARK: - State
    @Published var buses: [BusResponse]?
    @Published var appliedBus: BusResponse?
    @Published var selectedBus: BusResponse?
    @Published var showNotFoundBus = false
    var isFirstOnAppear: Bool = true
    
    // MARK: - Repository
    @Inject var busRepository: any BusRepository
    
    // MARK: - Method
    @MainActor
    func fetchBuses() async {
        do {
            buses = try await busRepository.fetchAllBus()
            buses = dummyBus
            if buses!.isEmpty {
                showNotFoundBus = true
            }
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func fetchAppledBus() async {
        do {
            appliedBus = try await busRepository.fetchAppliedBus()
            appliedBus = dummyBus[0] // dummy
        } catch {
            print(error)
        }
    }
}

extension BusApplyViewModel: OnAppearProtocol {
    @MainActor
    func fetchAllData() async {
        async let fetchBuses: () = fetchBuses()
        async let fetchAppledBus: () = fetchAppledBus()
        _ = await [fetchBuses, fetchAppledBus]
    }
}
