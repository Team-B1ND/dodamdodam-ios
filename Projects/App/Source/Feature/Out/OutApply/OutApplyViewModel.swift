//
//  OutApplyViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/21/24.
//

import Combine

class OutApplyViewModel: ObservableObject {
    
    // MARK: - State
    @Published var selection: Int = 0 {
        didSet {
            reasonText = ""
        }
    }
    @Published var reasonText: String = ""
    @Published var startAt: String = ""
    @Published var endAt: String = ""
    
    // MARK: - Repository
    @Inject var outGoingRepository: any OutGoingRepository
    @Inject var outSleepingRepository: any OutSleepingRepository
    
    // MARK: - Method
    @MainActor
    func onTapApplyButton() async {
        
        if selection == 0 {
            await postOutGoing()
        } else {
            await postOutSleeping()
        }
    }
    
    @MainActor
    func postOutGoing() async {
        
        do {
            try await outGoingRepository.postOutGoing(
                .init(
                    reason: reasonText,
                    startAt: startAt,
                    endAt: endAt
                )
            )
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func postOutSleeping() async {
        
        do {
            try await outSleepingRepository.postOutSleeping(
                .init(
                    reason: reasonText,
                    startAt: startAt,
                    endAt: endAt
                )
            )
        } catch let error {
            print(error)
        }
    }
}
