//
//  AddMemberViewModel.swift
//  Feature
//
//  Created by dgsw8th61 on 2/11/25.
//

import Foundation
import DIContainer
import Domain
import Shared

final class AddMemberViewModel: ObservableObject {
    // MARK: - State
    @Published var divisions: [DivisionOverviewResponse]?
    @Published var divisionMembers: [Int: [DivisionMemberResponse]] = [:]
    
    private var lastDivisionId: Int = 0
    private var isFetching = false

    // MARK: - Repository
    @Inject private var divisionRepository: DivisionRepository
    
    // MARK: - Method
    @MainActor
    func fetchDivisions(lastId: Int = 0) async {
        guard !isFetching else { return }
        isFetching = true

        do {
            let response = try await divisionRepository.fetchDivisions(
                .init(lastId: lastId, limit: 10, keyword: "")
            )
            if lastId == 0 {
                divisions = response
            } else {
                divisions?.append(contentsOf: response)
            }
            lastDivisionId = response.last?.id ?? lastDivisionId
        } catch {
            print(error)
        }

        isFetching = false
    }
    
    @MainActor
    func fetchDivisionMembers(divisionId: Int) async {
        guard divisionMembers[divisionId] == nil else { return }
        
        do {
            let members = try await divisionRepository.fetchDivisionMembers(id: divisionId, .init(status: .allowed))
            divisionMembers[divisionId] = members
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func addMembers(id: Int, memberId: [String]) async {
        do {
            try await divisionRepository.addMembers(id: id, request: .init(memberIdList: memberId))
        } catch {
            print(error)
        }
    }
}
