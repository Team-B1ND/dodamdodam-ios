//
//  NightStudyViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/28/24.
//

import Combine
import SignKit
import Domain
import DIContainer

class NightStudyViewModel: ObservableObject, OnAppearProtocol {
    
    // MARK: - State
    @Published var nightStudyData: [NightStudyResponse]?
    @Published var nightStudyProjectList: [NightStudyProjectResponse] = []
    @Published var isBanned: Bool = false
    @Published var banPeriod: NightStudyBanResponse?
    var isFirstOnAppear: Bool = true
    
    // MARK: - Repository
    @Inject var nightStudyRepository: any NightStudyRepository

    // MARK: - Method
    @MainActor
    func fetchAllData() async {
        if Sign.isLoggedIn {
            await fetchNightStudy()
            await fetchNightStudyProjects()
            await checkBanStatus()
        }
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await fetchAllData()
    }
    
    func clearData() {
        nightStudyData = nil
        nightStudyProjectList = []
        isBanned = false
        banPeriod = nil
    }
    
    @MainActor
    func fetchNightStudy() async {
        do {
            nightStudyData = try await nightStudyRepository.fetchNightStudy()
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func fetchNightStudyProjects() async {
        do {
            nightStudyProjectList = try await nightStudyRepository.fetchNightStudyProjects()
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func checkBanStatus() async {
        do {
            banPeriod = try await nightStudyRepository.checkBanStatus()
            isBanned = banPeriod != nil
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func deleteNightStudy(id: Int) async {
        do {
            try await nightStudyRepository.deleteNightStudy(id: id)
            await fetchAllData()
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func deleteNightStudyProject(id: Int) async {
        do {
            try await nightStudyRepository.deleteNightStudyProject(id: id)
            await fetchAllData()
        } catch let error {
            print(error)
        }
    }
    
    func convertProjectToNightStudy(_ project: NightStudyProjectResponse) -> NightStudyResponse {
        NightStudyResponse(
            id: project.id,
            content: project.name,
            status: project.status,
            doNeedPhone: false,
            reasonForPhone: nil,
            student: project.leader,
            rejectReason: nil,
            place: .project5,
            startAt: project.startAt,
            endAt: project.endAt,
            createdAt: .now,
            modifiedAt: nil
        )
    }
    
    @MainActor
    func onAppear() async {
        if isFirstOnAppear {
            isFirstOnAppear = false
            await fetchAllData()
        }
    }
}
