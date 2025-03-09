//
//  MyClubViewModel.swift
//  Feature
//
//  Created by dgsw30 on 3/8/25.
//

import Foundation
import Domain
import Shared
import Combine
import DIContainer

class MyClubViewModel: ObservableObject {
    // MARK: - State
    @Published var myApplyClub: [MyApplyClubResponse]? // 내신청
    @Published var joinRequests: [ClubJoinRequestsResponse]? // 제안
    @Published var myClubs: [MyClubResponse]? // 동아리 개설 신청
    @Published var joinedClubs: [JoinedClubResponse]? // 소속된 동아리
    @Published var clubRegisterTime: ClubRegisterTimeResponse? // 시간
    
    var isFirstOnAppear: Bool = true
    
    // MARK: - Repository
    @Inject private var clubRepository: ClubRepository
    
    // MARK: - Methods
    
    // 내신청
    @MainActor
    func fetchMyApplyClubs() async {
        do {
            myApplyClub = try await clubRepository.fetchMyApplyClubs()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // 제안
    @MainActor
    func fetchReceivedJoinRequests() async {
        do {
            joinRequests = try await clubRepository.fetchClubJoinRequests()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func acceptJoinRequest(id: Int) async {
        do {
            _ = try await clubRepository.acceptJoinRequest(id: id)
            await fetchReceivedJoinRequests()
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func rejectJoinRequest(id: Int) async {
        do {
            _ = try await clubRepository.rejectJoinRequest(id: id)
            await fetchReceivedJoinRequests()
        } catch let error {
            print(error)
        }
    }
    
    // 동아리 개설 신청
    @MainActor
    func fetchMyClubs() async {
        do {
            myClubs = try await clubRepository.fetchMyClubs()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // 소속된 동아리
    @MainActor
    func fetchJoinedClubs() async {
        do {
            joinedClubs = try await clubRepository.fetchJoinedClubs()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //시간
    @MainActor
    func fetchchClubRegisterTime() async {
        do {
            clubRegisterTime = try await clubRepository.fetchClubRegisterTime()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await fetchAllData()
    }
    
    @MainActor
    func clearData() {
        myApplyClub = nil
        joinRequests = nil
        myClubs = nil
        joinedClubs = nil
        clubRegisterTime = nil
    }
}

extension MyClubViewModel: OnAppearProtocol {
    @MainActor
    func fetchAllData() async {
        async let fetchMyApplyClubs: () = fetchMyApplyClubs()
        async let fetchReceivedJoinRequests: () = fetchReceivedJoinRequests()
        async let fetchMyClubs: () = fetchMyClubs()
        async let fetchJoinedClubs: () = fetchJoinedClubs()
        async let fetchchClubRegisterTime: () = fetchchClubRegisterTime()
        _ = await [fetchMyApplyClubs, fetchReceivedJoinRequests, fetchMyClubs, fetchJoinedClubs, fetchchClubRegisterTime]
    }
}
