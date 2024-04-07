//
//  AllViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/29/24.
//

import Combine
import SignKit

class AllViewModel: ObservableObject {
    
    // MARK: - State
    @Published var memberData: MemberResponse?
    
    // MARK: - Repository
    @Inject var memberRepository: any MemberRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() async {
        await fetchMemberData()
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
}
