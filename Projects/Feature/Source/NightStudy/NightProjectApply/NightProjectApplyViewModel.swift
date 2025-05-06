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
    @Published var projectName: String = ""
    @Published var projectDescription: String = ""
    @Published var startAt: Date = Date()
    @Published var endAt: Date = Calendar.current.date(byAdding: .day, value: 21, to: .now) ?? Date()
    @Published var projectType: NightStudyProjectType = .project1
    @Published var room: NightProjectPlace = .lab12
    
    @Published var searchText: String = ""
    @Published var searchResults: [NightStudyStudentResponse] = []
    @Published var selectedStudents: Set<Int> = []
    
    @Published var nightStudyApplyFailed: Bool = false
    @Published var nightStudyApplyAlertMessage: String = "프로젝트 심자 신청에 실패했습니다."
    
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
                    room: room,
                    students: Array(selectedStudents)
                )
            )
//            if result.status == 403 {
//                nightStudyApplyFailed = true
//                nightStudyApplyAlertMessage = "프로젝트 심자 신청 기간이 아닙니다."
//            }
        } catch let error {
            print(error)
            nightStudyApplyFailed = true
        }
    }
    
    @MainActor
    func searchStudents(query: String) async {
        do {
            searchResults = try await nightStudyRepository.searchStudents(query: query)
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
    
//    @MainActor
//    func convertToStudent(_ student: NightStudyStudentResponse) -> Student {
//        Student(
//            id: student.id,
//            name: student.name,
//            grade: student.grade,
//            room: student.room,
//            number: student.number, code: <#String#>,
//            phone: student.phone,
//            profileImage: student.profileImage
//        )
//    }
}
