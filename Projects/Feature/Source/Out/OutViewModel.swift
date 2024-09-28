//
//  OutViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/21/24.
//

import Combine
import SignKit
import Domain
import DIContainer

class OutViewModel: ObservableObject, OnAppearProtocol {
    
    // MARK: - State
    @Published var outGoingData: [OutGoingResponse]?
    @Published var outSleepingData: [OutSleepingResponse]?
    var isFirstOnAppear: Bool = true
    
    // MARK: - Repository
    @Inject var outGoingRepository: any OutGoingRepository
    @Inject var outSleepingRepository: any OutSleepingRepository

    // MARK: - Method
    @MainActor
    func fetchAllData() async {
        if Sign.isLoggedIn {
            await fetchOutData()
        }
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await fetchAllData()
    }
    
    @MainActor
    func clearData() {
        outGoingData = nil
        outSleepingData = nil
    }
    
    @MainActor
    func fetchOutData() async {
        do {
            outGoingData = try await outGoingRepository.fetchOutGoing()
            outSleepingData = try await outSleepingRepository.fetchOutSleeping()
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func deleteOutGoing(id: Int) async {
        do {
            try await outGoingRepository.deleteOutGoing(id: id)
            await onRefresh()
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func deleteOutSleeping(id: Int) async {
        do {
            try await outSleepingRepository.deleteOutSleeping(id: id)
            await onRefresh()
        } catch let error {
            print(error)
        }
    }
}
