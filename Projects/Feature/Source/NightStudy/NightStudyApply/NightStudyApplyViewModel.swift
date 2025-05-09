//
//  NightStudyApplyViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/28/24.
//

import Combine
import Foundation
import Domain
import DIContainer

class NightStudyApplyViewModel: ObservableObject {
    
    // MARK: - State
    @Published var place: NightStudyPlace = .project5
    @Published var reasonText: String = ""
    @Published var reasonForPhoneText: String = ""
    @Published var startAt: Date = Date()
    @Published var endAt: Date = Calendar.current.date(byAdding: .day, value: 14, to: .now) ?? Date()
    
    @Published var doNeedPhone: Bool = false
    
    @Published var nightStudyApplyFailed: Bool = false
    @Published var nightStudyApplyAlertMessage: String = "심야 자습 신청에 실패했습니다."
    
    // MARK: - Repository
    @Inject var nightStudyRepository: any NightStudyRepository
    
    // MARK: - Method
    
    @MainActor
    func postNightStudy() async {
        self.nightStudyApplyFailed = false
        do {
            let result = try await nightStudyRepository.postNightStudy(
                .init(
                    place: place.rawValue,
                    content: reasonText,
                    doNeedPhone: doNeedPhone,
                    reasonForPhone: reasonForPhoneText,
                    startAt: startAt.parse(from: .isoDate),
                    endAt: endAt.parse(from: .isoDate)
                )
            )
            print("날짜 : \(startAt.timeIntervalSinceReferenceDate - endAt.timeIntervalSinceReferenceDate)")
//            if result.status == 403 {
//                nightStudyApplyFailed = true
//                nightStudyApplyAlertMessage = "심야 자습 신청 기간이 아닙니다."
//            }
        } catch let error {
            print(error)
            nightStudyApplyFailed = true
        }
    }
}
