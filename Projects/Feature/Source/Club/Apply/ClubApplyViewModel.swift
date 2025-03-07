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

class ClubApplyViewModel: ObservableObject, OnAppearProtocol {
    // MARK: - State
    @Published var activityClubs: [ClubsResponse] = []
    @Published var freeClubs: [ClubsResponse] = []
    
    // MARK: - Selection Data
    @Published var activitySelections: [ClubsResponse?] = [nil, nil, nil]
    @Published var freeSelections: [(text: String, club: ClubsResponse?)] = [
        (text: "", club: nil)
    ]
    
    var activityMessage: String {
        let activityClubsName = activitySelections.compactMap { $0?.name }
        var message = ""
        
        for (index, clubName) in activityClubsName.enumerated() {
            let rank = index + 1
            message += "\(rank)지망: \(clubName)\n"
        }
        
        return message
    }
    
    var freeClubsMessage: String {
        let freeClubsName = freeSelections.compactMap { $0.club?.name }
        var message = ""
        
        for clubName in freeClubsName {
            message += "\(clubName)\n"
        }
        
        return message
    }
    
    var isFirstOnAppear: Bool = true
    // MARK: - Repository
    @Inject private var clubRepository: ClubRepository
    
    // MARK: - Methods
    @MainActor
    func fetchClubs() async {
        do {
            let allClubs = try await clubRepository.fetchClubs()
            self.activityClubs = allClubs.filter { $0.type == .activity }
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
            let activityRequests = activitySelections.compactMap { selection -> ClubApplyRequest? in
                guard let club = selection else { return nil }
                
                let priority: ClubPriority
                switch activitySelections.firstIndex(of: selection)! {
                case 0: priority = .first
                case 1: priority = .second
                case 2: priority = .third
                default: return nil
                }
                
                return ClubApplyRequest(
                    clubId: club.id,
                    clubPriority: priority,
                    introduction: nil
                )
            }
            
            let freeRequests = freeSelections.compactMap { selection -> ClubApplyRequest? in
                guard let club = selection.club else { return nil }
                
                return ClubApplyRequest(
                    clubId: club.id,
                    clubPriority: nil,
                    introduction: selection.text
                )
            }
            
            let allRequests = activityRequests + freeRequests
            if !allRequests.isEmpty {
                try await clubRepository.applyToClub(request: allRequests)
            }
        } catch let error {
            print("에러\(error.localizedDescription)")
        }
    }
    
    @MainActor
    func fetchAllData() async {
        async let fetchClubs: () = fetchClubs()
        _ = await fetchClubs
    }
}
