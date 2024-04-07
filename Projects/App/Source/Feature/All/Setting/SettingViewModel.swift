//
//  SettingViewModel.swift
//  DodamDodam
//
//  Created by Mercen on 4/6/24.
//

import Combine
import SignKit

class SettingViewModel: ObservableObject {
    
    // MARK: - Repository
    @Inject var memberRepository: any MemberRepository
    
    // MARK: - Method
    @MainActor
    func patchDeactivate() async throws {
        try await memberRepository.patchDeactivate()
    }
}
