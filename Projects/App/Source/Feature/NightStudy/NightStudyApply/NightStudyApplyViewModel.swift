//
//  NightStudyApplyViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/28/24.
//

import Combine
import Foundation

class NightStudyApplyViewModel: ObservableObject {
    
    // MARK: - State
    @Published var place: Place = .programming1
    @Published var reasonText: String = ""
    @Published var reasonForPhoneText: String = ""
    @Published var startAt: Date = Date()
    @Published var endAt: Date = Date()
    
    @Published var doNeedPhone: Bool = false
    @Published var isStartAtModalPresented: Bool = false
    @Published var isEndAtModalPresented: Bool = false
    @Published var isModalPresented: Bool = false
    
    // MARK: - Repository
    @Inject var nightStudyRepository: any NightStudyRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() {
        
        startAt = Date()
        endAt = Date()
    }
    
    @MainActor
    func postNightStudy() async {
        
        do {
            try await nightStudyRepository.postNightStudy(
                .init(
                    place: place.rawValue,
                    content: reasonText,
                    doNeedPhone: doNeedPhone,
                    reasonForPhone: reasonForPhoneText,
                    startAt: startAt.parseString(format: "yyyy-MM-dd"),
                    endAt: endAt.parseString(format: "yyyy-MM-dd")
                )
            )
        } catch let error {
            print(error)
        }
    }
}
