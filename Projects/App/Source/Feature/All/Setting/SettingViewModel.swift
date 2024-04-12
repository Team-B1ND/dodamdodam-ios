//
//  SettingViewModel.swift
//  DodamDodam
//
//  Created by Mercen on 4/6/24.
//

import Combine
import SignKit

class SettingViewModel: ObservableObject {
    
    // MARK: - State
    @Published var memberData: MemberResponse?
    
    // MARK: - Repository
    @Inject var memberRepository: any MemberRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() async {
        if Sign.isLoggedIn {
            await fetchMemberData()
        }
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await onAppear()
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
    func patchDeactivate() async throws {
        try await memberRepository.patchDeactivate()
    }
}
