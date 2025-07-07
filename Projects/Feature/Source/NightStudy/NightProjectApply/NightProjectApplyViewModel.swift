//
//  NightProjectApplyViewModel.swift
//  Feature
//
//  Created by dgsw30 on 4/17/25.
//

import Combine
import Foundation
import Domain
import DIContainer
import Shared

class NightProjectApplyViewModel: ObservableObject, OnAppearProtocol {
    
    // MARK: - State
    @Published var projectName: String = ""
    @Published var projectDescription: String = ""
    @Published var startAt: Date = Date()
    @Published var endAt: Date = Calendar.current.date(byAdding: .day, value: 20, to: .now) ?? Date()
    @Published var projectType: NightStudyProjectType = .project1
    
    @Published var searchText: String = ""
    @Published var searchResults: [NightStudyStudentResponse]?
    @Published var selectedStudents: Set<Int> = []
    
    @Published var nightStudyApplyFailed: Bool = false
    @Published var nightStudyApplyAlertMessage: String = "프로젝트 심자 신청에 실패했습니다."
    
    var isFirstOnAppear: Bool = true
    
    var filteredResults: [NightStudyStudentResponse] {
        guard let searchResults else { return [] }
        guard !searchText.isEmpty else { return searchResults }
        
        return searchResults.filter {
            $0.name.contains(searchText) ||
            "\($0.grade)\($0.room)\($0.number)".contains(searchText)
        }
    }
    
    // MARK: - Repository
    @Inject var nightStudyRepository: any NightStudyRepository
    
    // MARK: - Method
    @MainActor
    func postNightStudyProject() async {
        self.nightStudyApplyFailed = false
        do {
            let result = try await nightStudyRepository.postNightStudyProject(
                .init(
                    type: projectType,
                    name: projectName,
                    description: projectDescription,
                    startAt: startAt.parse(from: .isoDate),
                    endAt: endAt.parse(from: .isoDate),
                    students: Array(selectedStudents)
                )
            )
            if result.status == 403 {
                nightStudyApplyFailed = true
                nightStudyApplyAlertMessage = "프로젝트 신청 기간이 아닙니다."
            }
        } catch let error {
            print(error)
            nightStudyApplyFailed = true
        }
    }
    
    @MainActor
    func searchStudents() async {
        do {
            searchResults = try await nightStudyRepository.searchStudents()
        } catch let error {
            print(error)
        }
    }
    

    func toggleStudent(_ id: Int) {
        if selectedStudents.contains(id) {
            selectedStudents.remove(id)
        } else {
            selectedStudents.insert(id)
        }
    }
    
    @MainActor
    func fetchAllData() async {
    }
}
