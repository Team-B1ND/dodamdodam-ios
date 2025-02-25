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
    
    // MARK: - Method
    @MainActor
    func fetchAllData(id: Int) async {
        async let fetchDivisionMembers: () = fetchDivisionMembers(id: id)
        _ = await [fetchDivisionMembers]
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
    func addMembers(id: Int, memberId: [Int]) async {
        //TODO: 이거 커밋할때 [String]으로
        do {
            try await divisionRepository.addMembers(id: id,request: .init (memberIdList: memberId))
            
        } catch {
            print(error)
        }
    }
}
