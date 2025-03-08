//
//  DivisionWaitingViewModel.swift
//  Feature
//
//  Created by dgsw8th61 on 2/11/25.
//

import Foundation
import DIContainer
import Domain
import Shared

final class DivisionWaitingViewModel: ObservableObject {
    // MARK: - State
    @Published var divisionMember: [DivisionMemberResponse]?
        
    // MARK: - Repository
    @Inject private var divisionRepository: DivisionRepository
    var isFirstOnAppear: Bool = true
    
    private let divisionId: Int
    
    // MARK: - Method
    init(divisionId: Int) {
        self.divisionId = divisionId
    }
    
    @MainActor
    func onRefresh() async {
        await fetchAllData()
    }
    
    @MainActor
    func fetchDivisionMembers(id: Int) async {
        do {
            divisionMember = try await divisionRepository.fetchDivisionMembers(id: id, .init(status: .pending))
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func deleteMembers(id: Int, idList: [Int]) async {
        do {
            try await divisionRepository.deleteMembers(id: id,
                .init(
                    idList: idList
                )
            )
            
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func addMembers(id: Int, memberId: [String]) async {
        do {
            try await divisionRepository.addMembers(id: id,request: .init (memberIdList: memberId))
            
        } catch {
            print(error)
        }
    }
}

extension DivisionWaitingViewModel: OnAppearProtocol {
    @MainActor
    func fetchAllData() async {
        await fetchDivisionMembers(id: divisionId)
    }
}
