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

    // MARK: - Repository
    @Inject private var noticeRepository: NoticeRepository

    // MARK: - Method
    @MainActor
    func fetchAllData() async {
        async let fetchNotice: () = fetchNotice()
        _ = await [fetchNotice]
    }

    @MainActor
    func fetchNotice() async {
        do {
            notices = try await noticeRepository.fetchNotice(
                .init(keyword: nil,
                      lastId: 0,
                      limit: 10,
                      status: .created
                     )
            )
        } catch {
            print(error)
        }
    }
}
