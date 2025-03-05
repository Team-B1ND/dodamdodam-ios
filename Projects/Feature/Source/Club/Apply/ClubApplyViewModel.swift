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
import DIContainer

class ClubApplyViewModel: ObservableObject {
    // MARK: - State
    @Published var creativeClubs: [ClubsResponse] = []
    @Published var freeClubs: [ClubsResponse] = []
    
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
    @Inject private var clubRepository: ClubRepository
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Methods
    @MainActor
    func fetchClubs() async {
        
        do {
            let allClubs = try await clubRepository.fetchClubs()
            self.creativeClubs = allClubs.filter { $0.type == .activity }
            self.freeClubs = allClubs.filter { $0.type == .directActivity }
        } catch let error {
            print(error.localizedDescription)
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
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
