//
//  CreateClubCellViewModel.swift
//  Feature
//
//  Created by dgsw01 on 3/4/25.
//

import Foundation
import Domain
import Shared
import Combine
import DIContainer

class CreateClubCellViewModel: ObservableObject {
    // MARK: - State
    @Published var myClubs: [MyClubResponse]?
    var isFirstOnAppear: Bool = true
    
    // MARK: - Repository
    @Inject private var clubRepository: ClubRepository
    
    // MARK: - Methods
    @MainActor
    func fetchMyClubs() async {
        do {
            myClubs = try await clubRepository.fetchMyClubs()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func onRefresh() async {
        await fetchMyClubs()
    }
}

extension CreateClubCellViewModel: OnAppearProtocol {
    @MainActor
    func fetchAllData() async {
        async let fetchMyClubs: () = fetchMyClubs()
        _ = await fetchMyClubs
    }
}
