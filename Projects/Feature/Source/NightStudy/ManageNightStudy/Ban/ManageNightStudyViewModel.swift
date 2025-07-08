//
//  ManageNightStudyViewModel.swift
//  Feature
//
//  Created by 김은찬 on 7/4/25.
//

import Foundation
import Domain
import DIContainer

class ManageNightStudyViewModel: ObservableObject, OnAppearProtocol {
    @Published var approveNightStudy: [OngoingNightStudyResponse]?
    @Published var studentInfo: OngoingNightStudyResponse?
    @Published var searchText: String = ""
    @Published var reasoneText: String = ""
    @Published var endAt: Date?
    @Published var isModalPresented: Bool = false
    
    @Published var banNightStudyFailed: Bool = false
    @Published var banNightStudyAlertMessage: String = "심자 정지 실패"
    
    var isFirstOnAppear: Bool = true
    
    @Published var selectedGradeIndex: Int = 0
    @Published var selectedClassIndex: Int = 0
    var filteredStudents: [OngoingNightStudyResponse] {
        guard let data = approveNightStudy else { return [] }
        
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return data.filter { student in
            let matchesSearch = trimmed.isEmpty || student.student.name.localizedCaseInsensitiveContains(trimmed)
            let matchesGrade = selectedGradeIndex == 0 || student.student.grade == selectedGradeIndex
            let matchesClass = selectedClassIndex == 0 || student.student.room == selectedClassIndex
            return matchesSearch && matchesGrade && matchesClass
        }
    }
    
    // MARK: - Repository
    @Inject var nightStudyRepository: any NightStudyRepository
    
    @MainActor
    func fetchAllData() async {
        async let fetchApproveNightStudy: () = fetchApproveNightStudy()
        _ = await [fetchApproveNightStudy]
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await fetchAllData()
    }
    
    func clearData() {
        approveNightStudy = nil
    }
    
    @MainActor
    func fetchApproveNightStudy() async {
        do {
            approveNightStudy = try await nightStudyRepository.fetchApproveNightStudy()
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func banNightStudy(_ studentId: Int) async {
        self.banNightStudyFailed = false
        do {
            let result = try await nightStudyRepository.banNightStudy(
                .init(
                    student: studentId,
                    reason: reasoneText,
                    ended: endAt!.parse(from: .isoDate)
                )
            )
            if result.status == 403 {
                banNightStudyFailed = true
                banNightStudyAlertMessage = "오류가 발생했습니다."
            }
        } catch {
            print(error)
            banNightStudyFailed = true
        }
    }
}
