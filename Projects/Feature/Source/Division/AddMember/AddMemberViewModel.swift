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
    @Published var myDivisions: [DivisionOverviewResponse]?
    @Published var searchText = ""
    
    var isFirstOnAppear: Bool = true

    var searchedMyDivisions: [DivisionOverviewResponse]? {
        myDivisions?.search(text: searchText)
    }
    
    // MARK: - Repository
    @Inject private var divisionRepository: DivisionRepository
    
    // MARK: - Method
    @MainActor
    func fetchAllData() async {
        async let fetchMyDivisions: () = fetchMyDivisions()
        _ = await [fetchMyDivisions]
    }
    
    @MainActor
    func fetchMyDivisions() async {
        do {
            myDivisions = try await divisionRepository.fetchMyDivision(
                .init(
                    lastId: 0,
                    limit: 100
                )
            )
        } catch {
            print(error)
        }
    }
}
