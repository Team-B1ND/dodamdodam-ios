//
//  DivisionViewModel.swift
//  Feature
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation
import Combine
import DIContainer
import Domain
import Shared

final class DivisionViewModel: ObservableObject {
    // MARK: - State
    @Published var divisions: [DivisionOverviewResponse]?
    @Published var searchDivisions: [DivisionOverviewResponse]?
    @Published var myDivisions: [DivisionOverviewResponse]?
    @Published var searchMyDivisions: [DivisionOverviewResponse]?
    @Published var searchText = ""
    
    private var subscriptions = Set<AnyCancellable>()
    var isFirstOnAppear: Bool = true
    
    var currentDivisions: [DivisionOverviewResponse]? {
        searchText.isEmpty ? divisions : searchDivisions
    }
    var currentMyDivisions: [DivisionOverviewResponse]? {
        searchText.isEmpty ? myDivisions : searchMyDivisions
    }
    
    // MARK: - Repository
    @Inject private var divisionRepository: DivisionRepository
    
    // MARK: - Method
    init() {
        $searchText
            .dropFirst()
            .debounce(for: 1, scheduler: RunLoop.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
            .sink { [weak self] _ in
                Task {
                    print("division 검색 : \(self?.searchText ?? "")")
                    await self?.clearData()
                    await self?.fetchAllData()
                }
            }
            .store(in: &subscriptions)
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await fetchAllData()
    }
    
    @MainActor
    func clearData() {
        divisions = nil
        myDivisions = nil
        searchDivisions = nil
        searchMyDivisions = nil
    }
    
    @MainActor
    func fetchDivisions(lastId: Int = 0) async {
        do {
            let response = try await divisionRepository.fetchDivisions(
                .init(
                    lastId: lastId,
                    limit: DivisionView.pagingInterval,
                    keyword: searchText
                )
            )
            if searchText.isEmpty {
                if divisions == nil {
                    divisions = response
                } else {
                    divisions?.append(contentsOf: response)
                }
            } else {
                if searchDivisions == nil {
                    searchDivisions = response
                } else {
                    searchDivisions?.append(contentsOf: response)
                }
            }
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func fetchMyDivisions(lastId: Int = 0) async {
        do {
            let response = try await divisionRepository.fetchMyDivision(
                .init(
                    lastId: lastId,
                    limit: DivisionView.pagingInterval,
                    keyword: searchText
                )
            )
            if searchText.isEmpty {
                if myDivisions == nil {
                    myDivisions = response
                } else {
                    myDivisions?.append(contentsOf: response)
                }
            } else {
                if searchMyDivisions == nil {
                    searchMyDivisions = response
                } else {
                    searchMyDivisions?.append(contentsOf: response)
                }
            }
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
