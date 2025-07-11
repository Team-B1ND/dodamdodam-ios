//
//  AllViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/29/24.
//

import Combine
import SignKit
import Domain
import DIContainer

class AllViewModel: ObservableObject, OnAppearProtocol {
    
    // MARK: - State
    @Published var memberData: MemberResponse?
    @Published var isProjectManger: Bool = false
    var isFirstOnAppear: Bool = true
    
    // MARK: - Repository
    @Inject var memberRepository: any MemberRepository
    
    // MARK: - Method
    @MainActor
    func fetchAllData() async {
        if Sign.isLoggedIn {
            async let fetchMemberData: () = fetchMemberData()
            async let checkProjectManger: () = checkProjectManger()
            _ = await [fetchMemberData, checkProjectManger]
        }
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await fetchAllData()
    }
    
    func clearData() {
        memberData = nil
    }
    
    @MainActor
    func fetchMemberData() async {
        do {
            memberData = try await memberRepository.fetchInfo()
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func checkProjectManger() async {
        do {
            isProjectManger = try await memberRepository.checkNightStudyManager()
        } catch {
            print(error)
        }
    }
    
}
