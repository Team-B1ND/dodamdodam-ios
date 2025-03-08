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
    @Published var waitingMemberCount: Int?
    var isFirstOnAppear: Bool = true
    private let divisionId: Int
        
    // MARK: - Repository
    @Inject private var divisionRepository: DivisionRepository
    
    // MARK: - Method
    init(divisionId: Int) {
        self.divisionId = divisionId
    }
    
    @MainActor
    func onRefresh() async {
        await fetchAllData()
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
            await fetchDivision(id: divisionId)
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

extension DivisionDetailViewModel: OnAppearProtocol {
    
    @MainActor
    func fetchAllData() async {
        async let fetchDivision: () = fetchDivision(id: divisionId)
        async let fetchDivisionMembers: () = fetchDivisionMembers(id: divisionId)
        async let fetchDivisionWaitingMembers: () = fetchDivisionWaitingMembers(id: divisionId)
        _ = await [fetchDivision, fetchDivisionMembers, fetchDivisionWaitingMembers]
    }
}
