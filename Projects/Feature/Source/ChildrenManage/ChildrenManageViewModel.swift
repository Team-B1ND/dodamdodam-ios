//
//  ChildrenManageView.swift
//  Feature
//
//  Created by hhhello0507 on 2/4/25.
//

import SwiftUI
import Domain
import DIContainer

protocol ChildrenManageViewModel: ObservableObject {
    var studentCode: String { get set }
    var relation: String { get set }
    var etcRelation: String { get set }
    var isETCMode: Bool { get set }
    var isNotFoundMember: Bool { get set }
    
    func makeRelation() async -> ConnectStudent?
}

extension ChildrenManageViewModel {
    var currentRelation: String {
        isETCMode ? etcRelation : relation
    }
    
    var isValidInput: Bool {
        studentCode.count == 8 && !currentRelation.isEmpty
    }
}

class ChildrenManageViewModelImpl: ChildrenManageViewModel, OnAppearProtocol {
    // MARK: State
    @Published var studentCode: String = ""
    @Published var relation: String = ""
    @Published var etcRelation: String = ""
    @Published var isETCMode: Bool = false
    @Published var isNotFoundMember: Bool = false
    @Published var connectStudents: [ConnectStudent] = []
    var isFirstOnAppear: Bool = true
    
    // MARK: Repository
    @Inject private var memberRepository: MemberRepository
    
    // MARK: Method
    func clearData() {
        studentCode = ""
        relation = ""
        etcRelation = ""
        isETCMode = false
        isNotFoundMember = false
    }
    
    @MainActor
    func fetchAllData() async {
        await fetchRelation()
    }
    
    @MainActor
    func fetchRelation() async {
        do {
            let relation = try await memberRepository.fetchRelation()
            connectStudents = relation.map { $0.toModel() }
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func makeRelation() async -> ConnectStudent? {
        do {
            try await memberRepository.postRelation(
                .init(code: studentCode, relation: currentRelation)
            )
            clearData()
            await fetchRelation()
        } catch {
            print(error)
        }
        
        return nil
    }
}

class ChildrenManageViewModelForRegister: ChildrenManageViewModel {
    // MARK: State
    @Published var studentCode: String = ""
    @Published var relation: String = ""
    @Published var etcRelation: String = ""
    @Published var isETCMode: Bool = false
    @Published var isNotFoundMember: Bool = false
    
    // MARK: Repository
    @Inject private var memberRepository: MemberRepository
    
    // MARK: Method
    @MainActor
    func makeRelation() async -> ConnectStudent? {
        do {
            let member = try await memberRepository.fetchMemberByCode(
                code: studentCode
            )
            return ConnectStudent(
                profileImage: member.profileImage,
                name: member.name,
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
