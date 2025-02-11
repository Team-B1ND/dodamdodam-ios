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
        
    // MARK: - Repository
    @Inject private var divisionRepository: DivisionRepository
    
    // MARK: - Method
    @MainActor
    func fetchAllData(id: Int) async {
        async let fetchDivision: () = fetchDivision(id: id)
        async let fetchDivisionMembers: () = fetchDivisionMembers(id: id)
        _ = await [fetchDivision, fetchDivisionMembers]
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
}
