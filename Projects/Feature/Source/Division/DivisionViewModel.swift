//
//  DivisionViewModel.swift
//  Feature
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation
import DIContainer
import Domain
import Shared

final class DivisionViewModel: ObservableObject {
    // MARK: - State
    @Published var divisions: [DivisionOverviewResponse]?
    @Published var myDivisions: [DivisionOverviewResponse]?
    @Published var searchText = ""
    
    var isFirstOnAppear: Bool = true
    var searchedDivisions: [DivisionOverviewResponse]? {
        divisions?.search(text: searchText)
    }
    var searchedMyDivisions: [DivisionOverviewResponse]? {
        myDivisions?.search(text: searchText)
    }
    
    // MARK: - Repository
    @Inject private var divisionRepository: DivisionRepository
    
    // MARK: - Method
    @MainActor
    func fetchDivisions() async {
        do {
            divisions = try await divisionRepository.fetchDivisions(
                .init(
                    lastId: 0,
                    limit: 100
                )
            )
        } catch {
            print(error)
        }
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

extension DivisionViewModel: OnAppearProtocol {
    @MainActor
    func fetchAllData() async {
        async let fetchDivisions: () = fetchDivisions()
        async let fetchMyDivisions: () = fetchMyDivisions()
        _ = await [fetchDivisions, fetchMyDivisions]
    }
}
