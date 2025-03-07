//
//  AffiliationCellViewModel.swift
//  Feature
//
//  Created by dgsw01 on 3/4/25.
//

import Foundation
import Domain
import Shared
import Combine
import DIContainer

class AffiliationCellViewModel: ObservableObject {
    // MARK: - State
    @Published var joinedClubs: [JoinedClubResponse]?
    @Published var myApplyClub: [MyApplyClubResponse]?
    @Published var clubRegisterTime: ClubRegisterTimeResponse?
    
    var isFirstOnAppear: Bool = true
    
    // MARK: - Repository
    @Inject private var clubRepository: ClubRepository
    
    // MARK: - Methods
    @MainActor
    func fetchJoinedClubs() async {
        do {
            joinedClubs = try await clubRepository.fetchJoinedClubs()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchMyApplyClubs() async {
        do {
            myApplyClub = try await clubRepository.fetchMyApplyClubs()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchchClubRegisterTime() async {
        do {
            clubRegisterTime = try await clubRepository.fetchClubRegisterTime()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func onRefresh() async {
        await fetchJoinedClubs()
    }
}

extension AffiliationCellViewModel: OnAppearProtocol {
    @MainActor
    func fetchAllData() async {
        async let fetchJoinedClubs: () = fetchJoinedClubs()
        async let fetchMyApplyClubs: () = fetchMyApplyClubs()
        async let fetchchClubRegisterTime: () = fetchchClubRegisterTime()
        _ = await [fetchJoinedClubs, fetchMyApplyClubs, fetchchClubRegisterTime]
    }
}
