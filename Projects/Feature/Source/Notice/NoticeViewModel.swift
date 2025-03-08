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
    @Published var selectedDivision: DivisionOverviewResponse?
    var isFirstOnAppear: Bool = true

    // MARK: - Repository
    @Inject private var noticeRepository: NoticeRepository
    @Inject private var divisionRepository: DivisionRepository

    // MARK: - Method
    @MainActor
    func clearData() {
        notices = nil
        myDivisions = nil
        selectedDivision = nil
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await fetchAllData()
    }
    
    @MainActor
    func fetchNotices(lastId: Int = 0) async {
        do {
            let response = try await noticeRepository.fetchNoticeByDivision(
                .init(lastId: lastId, id: selectedDivision?.id, limit: NoticeView.pagingInterval)
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
                .init(lastId: 0, limit: NoticeView.pagingInterval, keyword: "")
            )
        } catch {
            print(error)
        }
    }
}

extension NoticeViewModel: OnAppearProtocol {
    
    @MainActor
    func fetchAllData() async {
        async let fetchNotices: () = fetchNotices()
        async let fetchMyDivisions: () = fetchMyDivisions()
        _ = await [fetchNotices, fetchMyDivisions]
    }
}
