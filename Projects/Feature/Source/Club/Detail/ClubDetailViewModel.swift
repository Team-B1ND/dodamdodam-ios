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
