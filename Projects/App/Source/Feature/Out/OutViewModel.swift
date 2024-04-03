//
//  OutViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/21/24.
//

import Combine

class OutViewModel: ObservableObject {
    
    // MARK: - State
    @Published var selection: Int = 0
    @Published var outGoingData: [OutGoingResponse]?
    @Published var outSleepingData: [OutSleepingResponse]?
    @Published var isShowingDeleteAlert: Bool = false
    
    // MARK: - Repository
    @Inject var outGoingRepository: any OutGoingRepository
    @Inject var outSleepingRepository: any OutSleepingRepository

    // MARK: - Method
    @MainActor
    func onAppear() async {
        
        await fetchOutData()
    }
    
    @MainActor
    func onRefresh() async {
        
        clearData()
        await fetchOutData()
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
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func deleteOutSleeping(id: Int) async {
        
        do {
            try await outSleepingRepository.deleteOutSleeping(id: id)
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func clearData() {
        
        outGoingData = nil
        outSleepingData = nil
    }
}
