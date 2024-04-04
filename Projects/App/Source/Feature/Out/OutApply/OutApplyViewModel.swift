//
//  OutApplyViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/21/24.
//

import Combine
import Foundation

class OutApplyViewModel: ObservableObject {
    
    // MARK: - State
    @Published var selection: Int = 0 {
        didSet {
            reasonText = ""
        }
    }
    @Published var reasonText: String = ""
    @Published var startAt: Date = Date() {
        didSet {
            startDate = startAt.parseString(format: "M월 d일 HH:MM")
        }
    }
    @Published var endAt: Date = Date() {
        didSet {
            endDate = endAt.parseString(format: "M월 d일 HH:MM")
        }
    }
    @Published var startDate: String = ""
    @Published var endDate: String = ""
    
    @Published var isModalPresented: Bool = false
    @Published var focused: Bool = true
    
    // MARK: - Repository
    @Inject var outGoingRepository: any OutGoingRepository
    @Inject var outSleepingRepository: any OutSleepingRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() {
        
        startAt = Date()
        endAt = Date()
    }
    
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
                    startAt: startAt.parseString(
                        format: "yyyy-MM-dd'T'HH:mm:ss"
                    ),
                    endAt: endAt.parseString(
                        format: "yyyy-MM-dd'T'HH:mm:ss"
                    )
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
                    startAt: startAt.parseString(
                        format: "yyyy-MM-dd"
                    ),
                    endAt: endAt.parseString(
                        format: "yyyy-MM-dd"
                    )
                )
            )
        } catch let error {
            print(error)
        }
    }
}
