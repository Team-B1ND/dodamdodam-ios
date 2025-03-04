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

class AffiliationCellViewModel: ObservableObject {
    // MARK: - State
    @Published var joinedClubs: [JoinedClubResponse] = []
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    
    var isFirstOnAppear: Bool = true
    
    // MARK: - Repository
    private let clubRepository: any ClubRepository
    
    // MARK: - Init
    init(clubRepository: any ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    // MARK: - Methods
    @MainActor
    func fetchJoinedClubs() async {
        isLoading = true
        
        do {
            let clubs = try await clubRepository.fetchJoinedClubs()
            print("소속 동아리 불러오기 성공 \(clubs.count)개")
            self.joinedClubs = clubs
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = "소속 동아리 정보를 불러오는데 실패했습니다 \(error.localizedDescription)"
            print("소속 동아리 로드 오류 \(error)")
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
        await fetchJoinedClubs()
    }
}
