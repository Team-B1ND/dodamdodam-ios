//
//  ClubApplyViewModel.swift
//  Feature
//
//  Created by dgsw01 on 3/4/25.
//

import Foundation
import Domain
import Shared
import Combine

class ClubApplyViewModel: ObservableObject {
    // MARK: - State
    @Published var creativeClubs: [ClubsResponse] = []
    @Published var freeClubs: [ClubsResponse] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    @Published var successMessage: String?
    
    // MARK: - Selection Data
    @Published var creativeSelections: [(text: String, club: ClubsResponse?)] = [
        (text: "", club: nil),
        (text: "", club: nil),
        (text: "", club: nil)
    ]
    
    @Published var freeSelections: [(text: String, club: ClubsResponse?)] = [
        (text: "", club: nil)
    ]
    
    // MARK: - Repository
    private let clubRepository: any ClubRepository
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(clubRepository: any ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    // MARK: - Methods
    @MainActor
    func fetchClubs() async {
        isLoading = true
        
        do {
            let allClubs = try await clubRepository.fetchClubs()
            
            self.creativeClubs = allClubs.filter { $0.type == .activity }
            self.freeClubs = allClubs.filter { $0.type == .directActivity }
            
            print("창체 동아리: \(self.creativeClubs.count)개, 자율 동아리: \(self.freeClubs.count)개 로드됨")
            
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = "동아리 목록을 불러오는데 실패했습니다: \(error.localizedDescription)"
            showAlert = true
            print("동아리 로드 오류: \(error)")
        }
    }
    
    @MainActor
    func addFreeSelection() {
        if freeSelections.count < freeClubs.count {
            freeSelections.append((text: "", club: nil))
        }
    }
    
    @MainActor
    func applyToClub() async {
        isLoading = true
        
        do {
            for (index, selection) in creativeSelections.enumerated() {
                if let club = selection.club, !selection.text.isEmpty {
                    let priority: ClubPriority
                    switch index {
                    case 0: priority = .first
                    case 1: priority = .second
                    case 2: priority = .third
                    default: continue
                    }
                    
                    let request = ClubApplyRequest(
                        clubId: club.id,
                        clubPriority: priority,
                        introduction: selection.text
                    )
                    
                    print("창체 동아리 신청: \(club.name), 지망: \(priority.rawValue)")
                    try await clubRepository.applyToClub(request: request)
                }
            }
    
            for selection in freeSelections {
                if let club = selection.club, !selection.text.isEmpty {
                    let request = ClubApplyRequest(
                        clubId: club.id,
                        clubPriority: nil,
                        introduction: selection.text
                    )
                    
                    print("자율 동아리 신청: \(club.name)")
                    try await clubRepository.applyToClub(request: request)
                }
            }
            
            isLoading = false
            successMessage = "동아리 입부 신청 성공"
            showAlert = true
        } catch {
            isLoading = false
            errorMessage = "동아리 신청에 실패했습니다: \(error.localizedDescription)"
            showAlert = true
            print("동아리 신청 오류: \(error)")
        }
    }
}
