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

class NightStudyViewModel: ObservableObject {
    
    // MARK: - State
    @Published var nightStudyData: [NightStudyResponse]?
    
    // MARK: - Repository
    @Inject var nightStudyRepository: any NightStudyRepository

    // MARK: - Method
    @MainActor
    func onAppear() async {
        if Sign.isLoggedIn {
            await fetchNightStudy()
        }
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await fetchNightStudy()
    }
    
    func clearData() {
        nightStudyData = nil
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
    func deleteNightStudy(id: Int) async {
        do {
            try await nightStudyRepository.deleteNightStudy(id: id)
            await onRefresh()
        } catch let error {
            print(error)
        }
    }
}
