//
//  ChildrenManageView.swift
//  Feature
//
//  Created by hhhello0507 on 2/4/25.
//

import SwiftUI
import Domain
import DIContainer

class ChildrenManageViewModel: ObservableObject {
    // MARK: State
    @Published var studentCode: String = ""
    @Published var relation: String = ""
    @Published var etcRelation: String = ""
    @Published var isETCMode: Bool = false
    @Published var isNotFoundMember: Bool = false
    
    var currentRelation: String {
        isETCMode ? etcRelation : relation
    }
    
    var isValidInput: Bool {
        studentCode.count == 8 && !currentRelation.isEmpty
    }
    
    // MARK: Repository
    @Inject private var memberRepository: MemberRepository
    
    // MARK: Method
    @MainActor
    func getChild() async -> ConnectStudent? {
        do {
            let member = try await memberRepository.fetchMemberByCode(
                code: studentCode
            )
            return ConnectStudent(
                member: member,
                code: studentCode,
                relation: currentRelation
            )
        } catch {
            print(error)
            self.isNotFoundMember = true
            
            return nil
        }
    }
}
