//
//  NoticeViewModel.swift
//  Feature
//
//  Created by dgsw8th61 on 2/13/25.
//

import Foundation
import DIContainer
import Domain
import Shared

final class NoticeViewModel: ObservableObject {
    // MARK: - State
    @Published var notices: [NoticeResponse]?
    @Published var myDivisions: [DivisionOverviewResponse]?
    @Published var selectedCategoryId: Int? 

    // MARK: - Repository
    @Inject private var noticeRepository: NoticeRepository
    @Inject private var divisionRepository: DivisionRepository

    // MARK: - Method
    @MainActor
    func fetchAllData() async {
        async let fetchNotices: () = fetchNotices()
        async let fetchMyDivisions: () = fetchMyDivisions()
        _ = await [fetchNotices, fetchMyDivisions]
    }

    @MainActor
    func fetchNotices(lastId: Int = 0) async {
        guard selectedCategoryId == nil else {
            await fetchCategoryNotice(id: selectedCategoryId!, lastId: lastId)
            return
        }

        do {
            let response = try await noticeRepository.fetchNotice(
                .init(lastId: lastId, limit: 10, status: .created)
            )
            if lastId == 0 {
                notices = response
            } else {
                notices?.append(contentsOf: response)
            }
        } catch {
            print(error)
        }
    }

    @MainActor
    func fetchMyDivisions() async {
        do {
            myDivisions = try await divisionRepository.fetchMyDivision(
                .init(lastId: 0, limit: 100, keyword: "")
            )
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func fetchCategoryNotice(id: Int, lastId: Int = 0) async {
        do {
            let response = try await noticeRepository.fetchCategoryNotice(id: id,
                .init(lastId: lastId, id: id, limit: 10)
            )
            if lastId == 0 {
                notices = response
            } else {
                notices?.append(contentsOf: response)
            }
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func selectCategory(_ id: Int?) {
        selectedCategoryId = id
        notices = nil
        Task {
            await fetchNotices()
        }
    }
}
