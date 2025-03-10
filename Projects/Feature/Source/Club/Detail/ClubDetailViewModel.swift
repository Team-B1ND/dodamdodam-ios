//
//  ClubDetailViewModel.swift
//  Feature
//
//  Created by dgsw30 on 2/27/25.
//

import Foundation
import Combine
import DIContainer
import Domain
import Shared

final class ClubDetailViewModel: ObservableObject, OnAppearProtocol {
    // MARK: - State
    @Published var clubMembers: ClubMembersInfoResponse?
    @Published var clubDetail: ClubDetailResponse?
    @Published var clubId: Int?
    
    var isFirstOnAppear: Bool = true
    
    init(clubId: Int) {
        self.clubId = clubId
    }
    
    // MARK: - Method
    @Inject private var clubRepository: ClubRepository
    
    // MARK: - Repository
    @MainActor
    func fetchClubDetail(id: Int) async {
        do {
            clubDetail = try await clubRepository.fetchClubDetail(id: id)
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func fetchClubMembers(id: Int) async {
        do {
            clubMembers = try await clubRepository.fetchClubMembers(id: id)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchAllData() async {
        guard let id = clubId else { return }
        async let fetchClubDetail: () = fetchClubDetail(id: id)
        async let fetchClubMember: () = fetchClubMembers(id: id)
        _ = await [fetchClubDetail, fetchClubMember]
    }
}
