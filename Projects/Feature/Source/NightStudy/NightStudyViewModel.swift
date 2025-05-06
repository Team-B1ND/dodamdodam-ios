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
    @Published var nightProjectData: [NightStudyProjectResponse]?
    @Published var banPeriod: NightStudyBanResponse?
    @Published var isBanned: Bool = false
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
        nightProjectData = nil
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
            nightProjectData = try await nightStudyRepository.fetchNightStudyProjects()
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
    func onAppear() async {
        if isFirstOnAppear {
            isFirstOnAppear = false
            await fetchAllData()
        }
    }
}
