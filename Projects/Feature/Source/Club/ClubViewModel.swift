//
//  ClubViewModel.swift
//  Feature
//
//  Created by dgsw30 on 2/26/25.
//

import Foundation
import Combine
import DIContainer
import Domain
import Shared

final class ClubViewModel: ObservableObject {
    // MARK: - State
    @Published var clubs: [ClubsResponse]?
    
    var isFirstOnAppear: Bool = true
    
    // MARK: - Repository
    @Inject private var clubRepository: ClubRepository
    
    // MARK: - Method
    @MainActor
    func fetchClubs() async {
        do {
            clubs = try await clubRepository.fetchClubs()
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await fetchAllData()
    }
    
    @MainActor
    func clearData() {
        clubs = nil
    }
}

extension ClubViewModel: OnAppearProtocol {
    @MainActor
    func fetchAllData() async {
        async let fetchClubs: () = fetchClubs()
        _ = await fetchClubs
    }
}
