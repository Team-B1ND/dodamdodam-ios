//
//  DivisionDetailViewModel.swift
//  Feature
//
//  Created by dgsw8th61 on 2/9/25.
//

import Foundation
import DIContainer
import Domain
import Shared

final class DivisionDetailViewModel: ObservableObject {
    // MARK: - State
    @Published var division: DivisionDetailResponse?
    @Published var divisionMember: [DivisionMemberResponse]?
    @Published var divisionWaitingMember: [DivisionMemberResponse]?
    @Published var waitingMemberCount: Int? = nil
        
    // MARK: - Repository
    @Inject private var divisionRepository: DivisionRepository
    
    // MARK: - Method
    @MainActor
    func fetchAllData(id: Int) async {
        async let fetchDivision: () = fetchDivision(id: id)
        async let fetchDivisionMembers: () = fetchDivisionMembers(id: id)
        async let fetchDivisionWaitingMembers: () = fetchDivisionWaitingMembers(id: id)
        _ = await [fetchDivision, fetchDivisionMembers, fetchDivisionWaitingMembers]
    }
    
    @MainActor
    func fetchDivision(id: Int) async {
        do {
            division = try await divisionRepository.fetchDivision(id: id)
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func fetchDivisionMembers(id: Int) async {
        do {
            divisionMember = try await divisionRepository.fetchDivisionMembers(id: id, .init(status: .allowed))
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
    func applyMemberDivision(id: Int) async {
        do {
            try await divisionRepository.applyMemberDivision(id: id)
            
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func fetchDivisionWaitingMembers(id: Int) async {
        do {
            let waitingMembers = try await divisionRepository.fetchDivisionMembers(id: id, .init(status: .pending))
            divisionWaitingMember = waitingMembers
            waitingMemberCount = waitingMembers.count
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func patchMemberPermission(id: Int, divisionMemberId: Int, permission: DivisionPermission) async {
        do {
            try await divisionRepository.patchMemberPermission(id: id, divisionMemberId: divisionMemberId, .init(permission: permission))
        } catch {
            print(error)
        }
    }
}
