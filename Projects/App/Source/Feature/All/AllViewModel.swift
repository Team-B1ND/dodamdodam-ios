//
//  AllViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/29/24.
//

import Combine
import SignKit

class AllViewModel: ObservableObject {
    
    @Published var memberData: MemberResponse?
    @Inject var memberRepository: any MemberRepository
    
    func onAppear() async {
        await fetchMemberData()
    }
    
    func fetchMemberData() async {
        do {
            memberData = try await memberRepository.fetchInfo()
        } catch let error {
            print(error)
        }
    }
    
    func onTapLogoutButton(_ completion: @escaping () -> Void) {
        Sign.logout()
        completion()
    }
}
