//
//  ApproveNightStudyViewModel.swift
//  Feature
//
//  Created by 김은찬 on 7/7/25.
//

import Foundation
import Domain
import DIContainer

class ApproveNightStudyViewModel: ObservableObject, OnAppearProtocol {
    @Published var pendingNightStudy: [OngoingNightStudyResponse]?
    @Published var studentInfo: OngoingNightStudyResponse?
    @Published var isModalPresented: Bool = false
    
    @Published var nightStudyFailed: Bool = false
    @Published var nightStudyAlertMessage: String = "심자 승인 실패"
    
    var isFirstOnAppear: Bool = true
    
    @Published var searchText: String = ""
    @Published var selectedGradeIndex: Int = 0
    @Published var selectedClassIndex: Int = 0
    var filteredStudents: [OngoingNightStudyResponse] {
        guard let data = pendingNightStudy else { return [] }
        
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
        async let fetchPendingNightStudy: () = fetchPendingNightStudy()
        _ = await [fetchPendingNightStudy]
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await fetchAllData()
    }
    
    func clearData() {
        pendingNightStudy = nil
    }
    
    @MainActor
    func fetchPendingNightStudy() async {
        do {
            pendingNightStudy = try await nightStudyRepository.fetchPendingNightStudy()
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func approveNightStudy(id: Int) async {
        self.nightStudyFailed = false
        do {
            let result = try await nightStudyRepository.allowNightStudy(id: id)
            if result.status == 403 {
                nightStudyFailed = true
                nightStudyAlertMessage = "오류가 발생했습니다."
            }
        } catch {
            print(error)
            nightStudyFailed = true
        }
    }
    
    @MainActor
    func rejectNightStudy(id: Int) async {
        self.nightStudyFailed = false
        do {
            let result = try await nightStudyRepository.rejectNightStudy(id: id)
            if result.status == 403 {
                nightStudyFailed = true
                nightStudyAlertMessage = "오류가 발생했습니다."
            }
        } catch {
            print(error)
            nightStudyFailed = true
        }
    }
}
