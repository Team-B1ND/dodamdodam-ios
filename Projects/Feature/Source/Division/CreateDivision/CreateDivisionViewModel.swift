//
//  CreateDivisionViewModel.swift
//  Feature
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation
import Domain
import DIContainer

final class CreateDivisionViewModel: ObservableObject {
    // MARK: - State
    @Published var divisionName: String = ""
    @Published var description: String = ""
    
    var isValidInput: Bool {
        !divisionName.isEmpty && !description.isEmpty && description.count <= 300
    }
    
    // MARK: - Repository
    @Inject private var divisionRepository: DivisionRepository
    
    // MARK: - Method
    @MainActor
    func createDivision(complection: @escaping () -> Void) async {
        do {
            try await divisionRepository.createDivision(
                .init(
                    name: divisionName,
                    description: description
                )
            )
            complection()
        } catch {
            print(error)
        }
    }
}
