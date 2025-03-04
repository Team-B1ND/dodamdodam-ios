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

class CreateClubCellViewModel: ObservableObject {
    // MARK: - State
    @Published var myClubs: [MyClubResponse] = []
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
    func fetchMyClubs() async {
        isLoading = true
        
        do {
            let clubs = try await clubRepository.fetchMyClubs()
            print("내가 개설한 동아리 불러오기 성공: \(clubs.count)개")
            self.myClubs = clubs
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = "개설한 동아리 정보를 불러오는데 실패했습니다: \(error.localizedDescription)"
            print("개설한 동아리 로드 오류: \(error)")
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
        await fetchMyClubs()
    }
}
