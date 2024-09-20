//
//  OutApplyViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/21/24.
//

import Combine
import Foundation
import Domain
import DIContainer

class OutApplyViewModel: ObservableObject {
    
    // MARK: - State
    @Published var reasonText: String = ""
    @Published var dateAt: Date = Date()
    @Published var startAt: Date = Date()
    @Published var endAt: Date = Date()
    
    // MARK: - Repository
    @Inject var outGoingRepository: any OutGoingRepository
    @Inject var outSleepingRepository: any OutSleepingRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() async {
        startAt = Date()
        endAt = startAt
    }
    
    @MainActor
    func postOutGoing(dinnerOrNot: Bool) async {
        do {
            let dateAtString = dateAt.parse(from: .isoDate)
            let startAtTimeString = startAt.parseString(format: "HH:mm:ss")
            let entAtTimeString = endAt.parseString(format: "HH:mm:ss")
            
            try await outGoingRepository.postOutGoing(
                .init(
                    reason: reasonText,
                    startAt: "\(dateAtString)T\(startAtTimeString)",
                    endAt: "\(dateAtString)T\(entAtTimeString)",
                    dinnerOrNot: dinnerOrNot
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
                    startAt: startAt.parse(from: .isoDate),
                    endAt: endAt.parse(from: .isoDate)
                )
            )
        } catch let error {
            print(error)
        }
    }
}
