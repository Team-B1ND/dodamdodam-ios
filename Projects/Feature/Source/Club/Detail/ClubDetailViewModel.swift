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

final class ClubDetailViewModel: ObservableObject {
    // MARK: - State
    @Published var clubMembers: [ClubMembersResponse]?
    @Published var leaderMembers: [ClubAllMembersResponse]?
    @Published var clubDetail: ClubDetailResponse?
    
    var isFirstOnAppear: Bool = true
    
    // MARK: - Method
    @Inject private var clubRepository: ClubRepository
    
    // MARK: - Repository
    @MainActor
    func fetchClubDetail(id: Int = 0) async {
        do {
            clubDetail = try await clubRepository.fetchClubDetail(id: id)
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func fetchClubMembers(id: Int = 0) async {
        do {
            leaderMembers = try await clubRepository.fetchAllClubMembers(id: id)
        } catch {
            print(error)
            do {
                clubMembers = try await clubRepository.fetchClubMembers(id: id)
            } catch {
                print(error)
            }
        }
    }
}

extension ClubDetailViewModel: OnAppearProtocol {
    @MainActor
    func fetchAllData() async {
        async let fetchClubDetail: () = fetchClubDetail()
        async let fetchClubMembers: () = fetchClubMembers()
        _ = await [fetchClubDetail, fetchClubMembers]
    }
}
