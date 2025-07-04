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
    @Published var allowNightStudy: [OngoingNightStudyResponse]?
    @Published var pendingNightStudy: [OngoingNightStudyResponse]?
    
    var isFirstOnAppear: Bool = true
    
    // MARK: - Repository
    @Inject var nightStudyRepository: any NightStudyRepository
    
    @MainActor
    func fetchAllData() async {
        async let fetchAllNightStudy: () = fetchAllNightStudy()
        async let fetchPendingNightStudy: () = fetchPendingNightStudy()
        _ = await [fetchAllNightStudy, fetchPendingNightStudy]
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await fetchAllData()
    }
    
    func clearData() {
        allowNightStudy = nil
        pendingNightStudy = nil
    }
    
    @MainActor
    func fetchAllNightStudy() async {
        do {
            allowNightStudy = try await nightStudyRepository.fetchAllNightStudy()
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func fetchPendingNightStudy() async {
        do {
            pendingNightStudy = try await nightStudyRepository.fetchPendingNightStudy()
        } catch {
            print(error)
        }
    }
}
