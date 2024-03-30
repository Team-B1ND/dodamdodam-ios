//
//  AllViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/29/24.
//

import Combine

class AllViewModel: ObservableObject {
    
    @Published var memberData: MemberResponse?
    @Inject var memberRepository: any MemberRepository
    
    func getTestData() async {
        do {
            memberData = try await memberRepository.fetchInfo()
        } catch {
            print("테스트")
        }
    }
}
