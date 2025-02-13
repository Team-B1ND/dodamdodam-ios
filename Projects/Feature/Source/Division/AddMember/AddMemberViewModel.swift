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

    // MARK: - Repository
    @Inject private var divisionRepository: DivisionRepository
    
    // MARK: - Method
    @MainActor
    func fetchAllData() async {
        do {
            divisions = try await divisionRepository.fetchDivisions(
                .init(lastId: 0, limit: 100)
            )
            
            await fetchAllDivisionMembers()
        } catch {
            print(error)
        }
    }
    
    @MainActor
    private func fetchAllDivisionMembers() async {
        guard let divisions = divisions else { return }
        
        for division in divisions {
            if divisionMembers[division.id] == nil {
                do {
                    let members = try await divisionRepository.fetchDivisionMembers(id: division.id, .init(status: .allowed))
                    divisionMembers[division.id] = members
                } catch {
                    print(error)
                }
            }
        }
    }
}
