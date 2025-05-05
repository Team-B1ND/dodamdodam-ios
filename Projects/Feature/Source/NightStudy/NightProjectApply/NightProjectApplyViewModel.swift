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

class NightProjectApplyViewModel: ObservableObject {
    
    // MARK: - State
    @Published var place: NightProjectPlace = .lab12
    @Published var projectName: String = ""
    @Published var projectDescription: String = ""
    @Published var startAt: Date = Date()
    @Published var endAt: Date = Calendar.current.date(byAdding: .day, value: 13, to: .now) ?? Date()
    @Published var projectType: NightStudyProjectType = .project1
    
    @Published var doNeedPhone: Bool = false
    
    @Published var nightStudyApplyFailed: Bool = false
    @Published var nightStudyApplyAlertMessage: String = "심야 자습 신청에 실패했습니다."
    
    @Published var searchText: String = ""
    @Published var searchResults: [NightStudyStudentResponse] = []
    @Published var selectedStudents: Set<Int> = []
    
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
                    content: projectName,
                    doNeedPhone: doNeedPhone,
                    reasonForPhone: projectDescription,
                    startAt: startAt.parse(from: .isoDate),
                    endAt: endAt.parse(from: .isoDate)
                )
            )
            print("날짜 : \(startAt.timeIntervalSinceReferenceDate - endAt.timeIntervalSinceReferenceDate)")
            if result.status == 403 {
                nightStudyApplyFailed = true
                nightStudyApplyAlertMessage = "심야 자습 신청 기간이 아닙니다."
            }
        } catch let error {
            print(error)
            nightStudyApplyFailed = true
        }
    }
    
    @MainActor
    func postNightStudyProject() async {
        self.nightStudyApplyFailed = false
        do {
            _ = try await nightStudyRepository.postNightStudyProject(
                .init(
                    type: projectType,
                    name: projectName,
                    description: projectDescription,
                    startAt: startAt.parse(from: .isoDate),
                    endAt: endAt.parse(from: .isoDate),
                    room: place,
                    students: Array(selectedStudents)
                )
            )
        } catch {
            self.nightStudyApplyFailed = true
            self.nightStudyApplyAlertMessage = "프로젝트 심자 신청에 실패했습니다."
        }
    }
    
    @MainActor
    func searchStudents() async {
        do {
            let students = try await nightStudyRepository.searchStudents(query: searchText)
            searchResults = students.filter { !$0.isBanned }
        } catch {
            print("오류: \(error)")
        }
    }
    
    func toggleStudent(_ id: Int) {
        if selectedStudents.contains(id) {
            selectedStudents.remove(id)
        } else {
            selectedStudents.insert(id)
        }
    }
    
    var selectedStudentsList: [NightStudyStudentResponse] {
        searchResults.filter { selectedStudents.contains($0.id) }
    }
}
