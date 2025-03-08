//
//  MyApplyCellViewModel.swift
//  Feature
//
//  Created by dgsw30 on 3/8/25.
//

import Foundation
import Domain
import Shared
import Combine
import DIContainer

class MyApplyCellViewModel: ObservableObject {
    // MARK: - State
    @Published var myApplyClub: [MyApplyClubResponse]?
    
    var isFirstOnAppear: Bool = true
    
    // MARK: - Repository
    @Inject private var clubRepository: ClubRepository
    
    // MARK: - Methods
    
    @MainActor
    func fetchMyApplyClubs() async {
        do {
            myApplyClub = try await clubRepository.fetchMyApplyClubs()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension MyApplyCellViewModel: OnAppearProtocol {
    @MainActor
    func fetchAllData() async {
        async let fetchMyApplyClubs: () = fetchMyApplyClubs()
        _ = await fetchMyApplyClubs
    }
}
